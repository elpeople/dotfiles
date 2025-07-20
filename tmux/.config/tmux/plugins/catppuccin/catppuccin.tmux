#!/usr/bin/env bash

# Set path of script
PLUGIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run-shell "echo \"DEBUG: catppuccin.tmux is being sourced.\" >> ~/tmux_debug.log"

tmux source "${PLUGIN_DIR}/catppuccin_options_tmux.conf"
tmux source "${PLUGIN_DIR}/catppuccin_tmux.conf"

run-shell 'echo "DEBUG: catppuccin.tmux sourcing finished." >> ~/tmux_debug.log'
