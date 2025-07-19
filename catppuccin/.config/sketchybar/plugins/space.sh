#!/bin/sh

# Get current workspace from aerospace
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

# Check if this space is the current workspace
if [ "$NAME" = "space.$CURRENT_WORKSPACE" ]; then
    SELECTED="on"
else
    SELECTED="off"
fi

# Update the appearance based on selection
if [ "$SELECTED" = "on" ]; then
    sketchybar --set "$NAME" background.drawing=on background.color=0xff007acc
else
    sketchybar --set "$NAME" background.drawing=on background.color=0x40ffffff
fi
