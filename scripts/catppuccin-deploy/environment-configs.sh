#!/bin/bash
# Environment-specific configuration adjustments

# WSL clipboard configuration
setup_wsl_clipboard() {
    local config_file="$1"
    
    # Add WSL clipboard configuration
    cat >> "$config_file" << 'WSLEOF'

# WSL-specific clipboard configuration
if grep -q Microsoft /proc/version 2>/dev/null; then
    # WSL environment detected
    export DISPLAY=:0
    
    # Use Windows clipboard
    alias pbcopy='clip.exe'
    alias pbpaste='powershell.exe -command "Get-Clipboard" 2>/dev/null'
fi
WSLEOF
}

# Linux clipboard configuration  
setup_linux_clipboard() {
    local config_file="$1"
    
    cat >> "$config_file" << 'LINUXEOF'

# Linux-specific clipboard configuration
if command -v xclip &> /dev/null; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
elif command -v xsel &> /dev/null; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
fi
LINUXEOF
}

# Apply environment-specific configurations
apply_env_configs() {
    local os="$1"
    
    case $os in
        "wsl")
            # Apply WSL-specific configurations
            if [[ -f ~/.bashrc ]]; then
                setup_wsl_clipboard ~/.bashrc
            fi
            if [[ -f ~/.zshrc ]]; then
                setup_wsl_clipboard ~/.zshrc
            fi
            ;;
        "linux")
            # Apply Linux-specific configurations
            if [[ -f ~/.bashrc ]]; then
                setup_linux_clipboard ~/.bashrc
            fi
            if [[ -f ~/.zshrc ]]; then
                setup_linux_clipboard ~/.zshrc
            fi
            ;;
    esac
}

# Export functions
export -f setup_wsl_clipboard
export -f setup_linux_clipboard
export -f apply_env_configs
