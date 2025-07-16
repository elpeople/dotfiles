#!/bin/sh

i3status | while :; do
    read line
    bluetooth_status=$(/home/elpeople/dotfiles/local_bin/local/bin/bluetooth_status.sh)
    echo "BT: $bluetooth_status | $line"
done
