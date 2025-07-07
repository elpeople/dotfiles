#!/bin/bash
DEVICE="AlpsPS/2 ALPS DualPoint TouchPad"

# デバイスの現在の状態を確認
STATE=$(xinput list-props "$DEVICE" | grep "Device Enabled" | awk '{print $4}')

if [ "$STATE" = "1" ]; then
	xinput disable "$DEVICE"
	notify-send "タッチパッド" "無効化しました"
else
	xinput enable "$DEVICE"
	notify-send "タッチパッド" "有効化しました"
fi
