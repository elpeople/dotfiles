#!/bin/bash

echo "=== WSL2 サービス管理ガイド（systemctl代替） ==="
echo ""

# 関数定義
manage_service() {
    local service_name=$1
    local action=$2
    
    echo "--- $service_name サービス管理 ---"
    
    case $action in
        "status")
            echo "現在の状態確認:"
            sudo service $service_name status 2>/dev/null || echo "service コマンドでの確認失敗"
            echo ""
            echo "プロセス確認:"
            ps aux | grep -v grep | grep $service_name || echo "プロセスが見つかりません"
            ;;
        "start")
            echo "$service_name を起動中..."
            sudo service $service_name start 2>/dev/null || sudo /etc/init.d/$service_name start
            sleep 2
            manage_service $service_name "status"
            ;;
        "stop")
            echo "$service_name を停止中..."
            sudo service $service_name stop 2>/dev/null || sudo /etc/init.d/$service_name stop
            sleep 2
            manage_service $service_name "status"
            ;;
        "restart")
            echo "$service_name を再起動中..."
            sudo service $service_name restart 2>/dev/null || {
                sudo /etc/init.d/$service_name stop
                sleep 2
                sudo /etc/init.d/$service_name start
            }
            sleep 2
            manage_service $service_name "status"
            ;;
    esac
    echo ""
}

# メニュー表示
show_menu() {
    echo "利用可能なサービス:"
    echo "1. ssh     - SSH サーバー"
    echo "2. cron    - スケジュールタスク"
    echo "3. docker  - Docker コンテナ"
    echo "4. dbus    - D-Bus メッセージバス"
    echo "5. networking - ネットワーク設定"
    echo ""
    echo "アクション:"
    echo "- status  : 状態確認"
    echo "- start   : 開始"
    echo "- stop    : 停止"
    echo "- restart : 再起動"
    echo ""
}

# 使用例
show_examples() {
    echo "=== 使用例 ==="
    echo ""
    echo "# SSHサーバーの状態確認"
    echo "./service_management_guide.sh ssh status"
    echo ""
    echo "# SSHサーバーの起動"
    echo "./service_management_guide.sh ssh start"
    echo ""
    echo "# Dockerの再起動"
    echo "./service_management_guide.sh docker restart"
    echo ""
    echo "# 全サービスの状態確認"
    echo "./service_management_guide.sh all status"
    echo ""
}

# メイン処理
if [ $# -eq 0 ]; then
    show_menu
    show_examples
    exit 0
fi

SERVICE=$1
ACTION=${2:-status}

case $SERVICE in
    "ssh")
        manage_service "ssh" $ACTION
        ;;
    "cron")
        manage_service "cron" $ACTION
        ;;
    "docker")
        manage_service "docker" $ACTION
        ;;
    "dbus")
        manage_service "dbus" $ACTION
        ;;
    "networking")
        manage_service "networking" $ACTION
        ;;
    "all")
        if [ "$ACTION" = "status" ]; then
            echo "=== 全サービス状態確認 ==="
            for svc in ssh cron docker dbus networking; do
                manage_service $svc status
            done
        else
            echo "全サービスに対しては status のみ実行可能です"
        fi
        ;;
    *)
        echo "未対応のサービス: $SERVICE"
        show_menu
        ;;
esac