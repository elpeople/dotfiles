#!/bin/bash

echo "=== 軽量サービス管理ツール（systemd問題回避版） ==="
echo ""

# systemdに依存しないサービスのみを対象とする
declare -A SIMPLE_SERVICES
SIMPLE_SERVICES[cron]="/usr/sbin/cron"
SIMPLE_SERVICES[ssh]="/usr/sbin/sshd"

# より高度なサービス（systemd依存）
declare -A COMPLEX_SERVICES
COMPLEX_SERVICES[docker]="systemd依存のため利用不可"
COMPLEX_SERVICES[nginx]="設定ファイル要確認"
COMPLEX_SERVICES[apache2]="systemd依存のため利用不可"

manage_simple_service() {
    local service_name=$1
    local action=$2
    local binary_path=${SIMPLE_SERVICES[$service_name]}
    
    case $action in
        "status")
            echo "--- $service_name 状態確認 ---"
            local pid=$(pgrep -f "$service_name" | head -1)
            if [ -n "$pid" ]; then
                echo "✓ $service_name は動作中 (PID: $pid)"
                ps aux | grep -v grep | grep "$service_name" | head -2
            else
                echo "✗ $service_name は停止中"
            fi
            ;;
        "start")
            echo "--- $service_name 起動 ---"
            if pgrep -f "$service_name" > /dev/null; then
                echo "⚠️  $service_name は既に動作中です"
            else
                echo "🚀 $service_name を起動中..."
                case $service_name in
                    "cron")
                        sudo $binary_path
                        ;;
                    "ssh")
                        sudo $binary_path -D &
                        ;;
                esac
                sleep 2
                manage_simple_service "$service_name" "status"
            fi
            ;;
        "stop")
            echo "--- $service_name 停止 ---"
            local pids=$(pgrep -f "$service_name")
            if [ -z "$pids" ]; then
                echo "⚠️  $service_name は既に停止中です"
            else
                echo "🛑 $service_name を停止中..."
                sudo pkill -f "$service_name"
                sleep 2
                manage_simple_service "$service_name" "status"
            fi
            ;;
        "restart")
            manage_simple_service "$service_name" "stop"
            sleep 1
            manage_simple_service "$service_name" "start"
            ;;
    esac
    echo ""
}

# 手動プロセス管理のヘルパー
manual_process_management() {
    echo "=== 手動プロセス管理 ==="
    echo ""
    echo "1. プロセス確認:"
    echo "   ps aux | grep <プロセス名>"
    echo ""
    echo "2. プロセス終了:"
    echo "   sudo pkill <プロセス名>"
    echo "   sudo pkill -9 <プロセス名>  # 強制終了"
    echo ""
    echo "3. 特定のPID終了:"
    echo "   sudo kill <PID>"
    echo "   sudo kill -9 <PID>  # 強制終了"
    echo ""
    echo "4. ポート使用状況確認:"
    echo "   sudo netstat -tlnp | grep <ポート番号>"
    echo "   sudo ss -tlnp | grep <ポート番号>"
    echo ""
}

# 現在動作中のサービス確認
check_running_services() {
    echo "=== 現在動作中のサービス ==="
    echo ""
    
    echo "SSH関連:"
    ps aux | grep -v grep | grep sshd || echo "  SSHサービスなし"
    echo ""
    
    echo "Cron関連:"
    ps aux | grep -v grep | grep cron || echo "  Cronサービスなし"
    echo ""
    
    echo "ネットワークサービス:"
    sudo netstat -tlnp 2>/dev/null | grep LISTEN | head -10 || echo "  netstatコマンド利用不可"
    echo ""
    
    echo "Docker関連:"
    ps aux | grep -v grep | grep docker || echo "  Dockerサービスなし"
    echo ""
}

# 使用方法表示
show_usage() {
    echo "使用方法:"
    echo "  $0 <service> <action>"
    echo "  $0 check              # 動作中サービス確認"
    echo "  $0 manual             # 手動管理方法表示"
    echo ""
    echo "対応サービス:"
    for service in "${!SIMPLE_SERVICES[@]}"; do
        echo "  ✓ $service"
    done
    echo ""
    echo "systemd依存で利用困難:"
    for service in "${!COMPLEX_SERVICES[@]}"; do
        echo "  ✗ $service (${COMPLEX_SERVICES[$service]})"
    done
    echo ""
    echo "アクション: status, start, stop, restart"
    echo ""
}

# メイン処理
case ${1:-help} in
    "check")
        check_running_services
        ;;
    "manual")
        manual_process_management
        ;;
    "help"|"")
        show_usage
        ;;
    *)
        SERVICE=$1
        ACTION=${2:-status}
        
        if [[ -n "${SIMPLE_SERVICES[$SERVICE]}" ]]; then
            manage_simple_service "$SERVICE" "$ACTION"
        else
            echo "❌ 未対応または利用困難なサービス: $SERVICE"
            echo ""
            show_usage
        fi
        ;;
esac