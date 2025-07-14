#!/bin/bash

echo "=== WSL2 systemd 修復スクリプト ==="

# 現在の状況を確認
echo "1. 現在のプロセス状況:"
ps aux | grep -E "(systemd|init)" | head -5

echo -e "\n2. systemd設定確認:"
cat /etc/wsl.conf

echo -e "\n3. systemdソケットディレクトリ作成:"
sudo mkdir -p /run/systemd/private
sudo chmod 700 /run/systemd/private
ls -la /run/systemd/

echo -e "\n4. systemdサービス状況確認:"
sudo systemctl status 2>&1 | head -3

echo -e "\n=== 修復手順 ==="
echo "この問題を完全に解決するには、以下の手順を実行してください："
echo ""
echo "【方法1: PowerShell/コマンドプロンプトから（推奨）】"
echo "1. PowerShellまたはコマンドプロンプトを開く"
echo "2. 以下のコマンドを実行:"
echo "   wsl --shutdown"
echo "   wsl --distribution $(lsb_release -si)"
echo ""
echo "【方法2: WSL内から】"
echo "sudo shutdown -r now"
echo ""
echo "【方法3: 手動でsystemdを再起動】"
echo "sudo kill -TERM 1"
echo "sudo /lib/systemd/systemd --system --deserialize 1"
echo ""
echo "=== 一時的な回避策 ==="
echo "systemctlの代わりに以下を使用できます："
echo "- service コマンド: sudo service <service-name> start/stop/status"
echo "- 直接制御: sudo /etc/init.d/<service-name> start/stop/status"