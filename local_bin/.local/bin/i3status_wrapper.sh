#!/bin/sh

# スクリプトがあるディレクトリを取得
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

i3status | while :; do
    read line
    bluetooth_status="$($SCRIPT_DIR/bluetooth_status.sh)"
    echo "BT: $bluetooth_status | $line"
done
