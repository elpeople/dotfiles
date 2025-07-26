#!/bin/bash
# Emergency terminal reset for ?69h issue

echo "EMERGENCY TERMINAL RESET"
echo "========================"

# Kill any running rmpc processes
pkill -f rmpc 2>/dev/null

# Complete terminal reset sequence
printf '\e[!p'                    # Soft terminal reset
printf '\e[?1000l'                # Disable mouse tracking
printf '\e[?1001l'                # Disable highlight tracking
printf '\e[?1002l'                # Disable cell motion tracking
printf '\e[?1003l'                # Disable all motion tracking
printf '\e[?1004l'                # Disable focus reporting
printf '\e[?1005l'                # Disable UTF-8 mouse mode
printf '\e[?1006l'                # Disable SGR mouse mode
printf '\e[?1015l'                # Disable urxvt mouse mode
printf '\e[?69l'                  # Disable mode 69 specifically
printf '\e[?25h'                  # Show cursor
printf '\e[0m'                    # Reset all attributes
printf '\e[2J'                    # Clear screen
printf '\e[H'                     # Move cursor to home

# System-level reset
stty sane 2>/dev/null || true
tput reset 2>/dev/null || true
clear 2>/dev/null || true

echo "Terminal reset complete."
echo "Try running rmpc now."