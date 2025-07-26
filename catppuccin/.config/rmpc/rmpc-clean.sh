#!/bin/bash
# Ultimate rmpc wrapper to completely eliminate ?69h

# Function to clean terminal
clean_terminal() {
    # Reset all possible escape sequences
    printf '\e[?1000l\e[?1001l\e[?1002l\e[?1003l\e[?1004l\e[?1005l\e[?1006l\e[?1015l\e[?69l'
    printf '\e[?25h\e[0m\e[2J\e[H'
    
    # Force terminal reset
    stty sane 2>/dev/null
    tput init 2>/dev/null
    reset 2>/dev/null
}

# Function to run rmpc with cleanup
run_rmpc() {
    # Clean before
    clean_terminal
    
    # Set environment
    export TERM=xterm-256color
    export COLORTERM=truecolor
    
    # Trap to clean on exit
    trap 'clean_terminal; exit' INT TERM EXIT
    
    # Run rmpc with output filtering to remove ?69h
    rmpc --config ~/.config/rmpc/config.ron "$@" 2>&1 | sed 's/\x1b\[?69h//g'
    
    # Clean after
    clean_terminal
}

# Main execution
echo "Starting rmpc with complete ?69h elimination..."
run_rmpc "$@"