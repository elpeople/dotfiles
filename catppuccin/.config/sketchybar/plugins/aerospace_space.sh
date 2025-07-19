#!/bin/bash

# Debugging: Log script execution
echo "---" >> /tmp/sketchybar_debug.log
date >> /tmp/sketchybar_debug.log
echo "Script triggered for NAME=$NAME, SENDER=$SENDER" >> /tmp/sketchybar_debug.log

# "space."プレフィックスを削除して、現在のスペース番号を取得
CURRENT_SPACE_NUM=$(echo "$NAME" | sed 's/space\.//')

# AeroSpaceから現在フォーカスされているワークスペースの番号を取得
RAW_FOCUSED_WORKSPACE=$(/opt/homebrew/bin/aerospace list-workspaces --focused)
echo "Raw focused workspace output: '$RAW_FOCUSED_WORKSPACE'" >> /tmp/sketchybar_debug.log

# Trim whitespace and newlines from the output
FOCUSED_WORKSPACE_NUM=$(echo "$RAW_FOCUSED_WORKSPACE" | tr -d '[:space:]')
echo "Trimmed focused workspace: '$FOCUSED_WORKSPACE_NUM', Current item: '$CURRENT_SPACE_NUM'" >> /tmp/sketchybar_debug.log

if [ "$FOCUSED_WORKSPACE_NUM" = "$CURRENT_SPACE_NUM" ]; then
  # このスペースがアクティブな場合
  echo "Setting $NAME to active" >> /tmp/sketchybar_debug.log
  sketchybar --set "$NAME" background.color=0xff007acc \
                           icon.color=0xffffffff
else
  # このスペースが非アクティブな場合
  echo "Setting $NAME to inactive" >> /tmp/sketchybar_debug.log
  sketchybar --set "$NAME" background.color=0x40ffffff \
                           icon.color=0xff333333
fi
