#!/bin/bash

# Get the name of the connected bluetooth device
connected_device=$(bluetoothctl info | grep "Name:" | cut -d' ' -f2-)

if [ -n "$connected_device" ]; then
    echo "$connected_device"
else
    echo "Not Connected"
fi
