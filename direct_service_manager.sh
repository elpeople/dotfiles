#!/bin/bash

echo "=== 直接サービス管理ツール（systemd回避版） ==="
echo ""

# サービス設定
declare -A SERVICES
SERVICES[cron]="/usr/sbin/cron"
SERVICES[docker]="/usr/bin/dockerd"
SERVICES[nginx]="/usr/sbin/nginx"
SERVICES[apache2]="/usr/sbin/apache2"
SERVICES[mysql]="/usr/sbin/mysqld"
SERVICES[postgresql]="/usr/lib/postgresql/*/bin/postgres"

# 関数定義
check_service() {
    local service_name=$1
    local process_name=${2:-$service_name}
    
    echo "--- $service_name 状態確認 ---"
    local pid=$(pgrep -f "$process_name" | head -1)
    if [ -n "$pid" ]; then
        echo "✓ $service_name は動作中 (PID: $pid)"
        ps aux | grep -v grep | grep "$process_name" | head -3
    else
        echo "✗ $service_name は停止中"
    fi
    echo ""
}

start_service() {
    local service_name=$1
    local binary_path=${SERVICES[$service_name]}
    
    if [ -z "$binary_path" ]; then
        echo "❌ 未対応のサービス: $service_name"
        return 1
    fi
    
    echo "--- $service_name 起動 ---"
    
    # 既に動作中かチェック
    if pgrep -f "$service_name" > /dev/null; then
        echo "⚠️  $service_name は既に動作中です"
        check_service "$service_name"
        return 0
    fi
    
    # バイナリの存在確認
    local actual_binary=$(ls $binary_path 2>/dev/null | head -1)
    if [ ! -x "$actual_binary" ]; then
        echo "❌ $service_name のバイナリが見つかりません: $binary_path"
        return 1
    fi
    
    echo "🚀 $service_name を起動中..."
    case $service_name in
        "cron")
            sudo $actual_binary
            ;;
        "docker")
            sudo $actual_binary --host=unix:///var/run/docker.sock &
            ;;
        "nginx")
            sudo $actual_binary -t && sudo $actual_binary
            ;;
        "apache2")
            sudo $actual_binary -t && sudo $actual_binary -D FOREGROUND &
            ;;
        *)
            sudo $actual_binary &
            ;;
    esac
    
    sleep 2
    check_service "$service_name"
}

stop_service() {
    local service_name=$1
    
    echo "--- $service_name 停止 ---"
    local pids=$(pgrep -f "$service_name")
    
    if [ -z "$pids" ]; then
        echo "⚠️  $service_name は既に停止中です"
        return 0
    fi
    
    echo "🛑 $service_name を停止中..."
    sudo pkill -f "$service_name"
    sleep 2
    
    # 強制終了が必要な場合
    local remaining_pids=$(pgrep -f "$service_name")
    if [ -n "$remaining_pids" ]; then
        echo "🔨 強制終了中..."
        sudo pkill -9 -f "$service_name"
        sleep 1
    fi
    
    check_service "$service_name"
}

list_available_services() {
    echo "=== 利用可能なサービス ==="
    for service in "${!SERVICES[@]}"; do
        local binary_path=${SERVICES[$service]}
        local actual_binary=$(ls $binary_path 2>/dev/null | head -1)
        if [ -x "$actual_binary" ]; then
            echo "✓ $service ($actual_binary)"
        else
            echo "✗ $service (バイナリなし: $binary_path)"
        fi
    done
    echo ""
}

show_usage() {
    echo "使用方法:"
    echo "  $0 <service> <action>"
    echo ""
    echo "アクション:"
    echo "  status  - 状態確認"
    echo "  start   - 開始"
    echo "  stop    - 停止"
    echo "  restart - 再起動"
    echo "  list    - 利用可能なサービス一覧"
    echo ""
    echo "例:"
    echo "  $0 cron start"
    echo "  $0 docker status"
    echo "  $0 nginx restart"
    echo ""
}

# メイン処理
if [ $# -eq 0 ]; then
    show_usage
    list_available_services
    exit 0
fi

SERVICE=$1
ACTION=${2:-status}

case $ACTION in
    "list")
        list_available_services
        ;;
    "status")
        check_service "$SERVICE"
        ;;
    "start")
        start_service "$SERVICE"
        ;;
    "stop")
        stop_service "$SERVICE"
        ;;
    "restart")
        stop_service "$SERVICE"
        sleep 1
        start_service "$SERVICE"
        ;;
    *)
        echo "❌ 未対応のアクション: $ACTION"
        show_usage
        ;;
esac