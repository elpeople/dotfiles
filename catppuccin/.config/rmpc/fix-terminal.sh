#!/bin/bash
# Complete terminal reset script for rmpc

echo "Resetting terminal for rmpc..."

# Reset all possible mouse modes
printf '\e[?1000l'  # Normal mouse tracking
printf '\e[?1001l'  # Highlight mouse tracking  
printf '\e[?1002l'  # Cell motion mouse tracking
printf '\e[?1003l'  # All motion mouse tracking
printf '\e[?1004l'  # Focus reporting
printf '\e[?1005l'  # UTF-8 mouse mode
printf '\e[?1006l'  # SGR mouse mode
printf '\e[?1015l'  # urxvt mouse mode
printf '\e[?69l'    # Disable mode 69 specifically

# Reset cursor and screen
printf '\e[?25h'    # Show cursor
printf '\e[0m'      # Reset all attributes
printf '\e[2J'      # Clear screen
printf '\e[H'       # Move cursor to home

# Set terminal to a clean state
stty sane 2>/dev/null || true
reset 2>/dev/null || true

echo "Terminal reset complete. You can now run:"
echo "  rmpc"
echo "or"
echo "  ~/.config/rmpc/rmpc-wrapper.sh"