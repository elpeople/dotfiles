#!/bin/bash

WEATHER=$(curl -s "wttr.in/Fukuoka?format=%c%t")

sketchybar --set $NAME label="$WEATHER"
