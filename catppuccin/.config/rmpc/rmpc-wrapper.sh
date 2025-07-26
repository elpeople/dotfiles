#!/bin/bash
# rmpc wrapper script to handle terminal issues

# Set proper terminal environment
export TERM=xterm-256color

# Disable all mouse reporting modes that might cause ?69h issue
printf '\e[?1000l'  # Normal mouse tracking
printf '\e[?1001l'  # Highlight mouse tracking  
printf '\e[?1002l'  # Cell motion mouse tracking
printf '\e[?1003l'  # All motion mouse tracking
printf '\e[?1004l'  # Focus reporting
printf '\e[?1005l'  # UTF-8 mouse mode
printf '\e[?1006l'  # SGR mouse mode
printf '\e[?1015l'  # urxvt mouse mode
printf '\e[?25h'    # Show cursor
printf '\e[?69l'    # Disable specific mode that causes ?69h

# Clear any existing mouse modes
tput rmm 2>/dev/null || true

# Run rmpc with proper config
exec rmpc --config ~/.config/rmpc/config.ron "$@"