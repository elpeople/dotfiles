#!/bin/bash
# Catppuccin Dotfiles Deployment Script
# Supports: macOS, Linux, WSL

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if grep -q Microsoft /proc/version 2>/dev/null; then
            OS="wsl"
        else
            OS="linux"
        fi
    else
        OS="unknown"
    fi
    
    log_info "Detected OS: $OS"
}

# Check dependencies
check_dependencies() {
    log_info "Checking dependencies..."
    
    # Check for stow
    if ! command -v stow &> /dev/null; then
        log_error "GNU Stow is not installed. Please install it first."
        case $OS in
            "macos")
                log_info "Install with: brew install stow"
                ;;
            "linux"|"wsl")
                log_info "Install with: sudo apt install stow (Ubuntu/Debian) or sudo yum install stow (RHEL/CentOS)"
                ;;
        esac
        exit 1
    fi
    
    # Check for git
    if ! command -v git &> /dev/null; then
        log_error "Git is not installed. Please install it first."
        exit 1
    fi
    
    log_success "Dependencies check passed"
}

# Install tools based on OS
install_tools() {
    log_info "Installing required tools for $OS..."
    
    case $OS in
        "macos")
            if command -v brew &> /dev/null; then
                brew install bat eza ripgrep htop lazygit git-delta fzf
                # Install rmpc if not present
                if ! command -v rmpc &> /dev/null; then
                    log_warning "rmpc not found. Install manually with: cargo install rmpc"
                fi
            else
                log_warning "Homebrew not found. Please install tools manually."
            fi
            ;;
        "linux"|"wsl")
            # Update package list
            if command -v apt &> /dev/null; then
                sudo apt update
                sudo apt install -y bat exa ripgrep htop git fzf
                
                # Install delta manually if not available
                if ! command -v delta &> /dev/null; then
                    log_info "Installing git-delta..."
                    wget https://github.com/dandavison/delta/releases/latest/download/delta-*-x86_64-unknown-linux-gnu.tar.gz
                    tar -xzf delta-*.tar.gz
                    sudo mv delta-*/delta /usr/local/bin/
                    rm -rf delta-*
                fi
                
                # Install lazygit
                if ! command -v lazygit &> /dev/null; then
                    log_info "Installing lazygit..."
                    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
                    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
                    tar xf lazygit.tar.gz lazygit
                    sudo install lazygit /usr/local/bin
                    rm lazygit.tar.gz lazygit
                fi
                
            elif command -v yum &> /dev/null; then
                sudo yum install -y bat exa ripgrep htop git fzf
            else
                log_warning "Package manager not recognized. Please install tools manually."
            fi
            ;;
    esac
    
    log_success "Tool installation completed"
}

# Apply OS-specific configurations
apply_os_configs() {
    log_info "Applying OS-specific configurations..."
    
    case $OS in
        "wsl")
            # WSL-specific clipboard configuration
            log_info "Configuring WSL clipboard integration..."
            if [[ -f ~/.config/tmux/.tmux.conf.wsl ]]; then
                # WSL clipboard settings are already in place
                log_success "WSL tmux configuration found"
            fi
            ;;
        "linux")
            # Linux-specific configurations
            log_info "Configuring Linux-specific settings..."
            # Ensure xclip is installed for clipboard
            if command -v apt &> /dev/null; then
                sudo apt install -y xclip
            fi
            ;;
        "macos")
            # macOS-specific configurations
            log_info "macOS configurations already optimized"
            ;;
    esac
}

# Deploy catppuccin configurations
deploy_catppuccin() {
    log_info "Deploying Catppuccin configurations..."
    
    # Ensure we're in the dotfiles directory
    if [[ ! -d "catppuccin" ]]; then
        log_error "catppuccin directory not found. Are you in the dotfiles directory?"
        exit 1
    fi
    
    # Backup existing configurations
    BACKUP_DIR="$HOME/catppuccin_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    log_info "Creating backup at $BACKUP_DIR..."
    
    # Backup existing configs
    for config in bat fzf eza ripgrep htop lazygit rmpc git zsh bash ranger sketchybar; do
        if [[ -d "$HOME/.config/$config" ]] && [[ ! -L "$HOME/.config/$config" ]]; then
            cp -r "$HOME/.config/$config" "$BACKUP_DIR/" 2>/dev/null || true
        fi
    done
    
    # Apply stow
    log_info "Applying Stow configurations..."
    stow catppuccin
    
    log_success "Catppuccin configurations deployed successfully"
    log_info "Backup created at: $BACKUP_DIR"
}

# Verify deployment
verify_deployment() {
    log_info "Verifying deployment..."
    
    local errors=0
    
    # Check if symlinks are created correctly
    for config in bat fzf eza ripgrep htop lazygit rmpc git zsh bash; do
        if [[ -L "$HOME/.config/$config" ]]; then
            log_success "$config: ✓ Symlink created"
        else
            log_warning "$config: ✗ Symlink not found"
            ((errors++))
        fi
    done
    
    # Check ranger colorschemes
    if [[ -L "$HOME/.config/ranger/colorschemes/catppuccin_mocha.py" ]]; then
        log_success "ranger catppuccin: ✓ Symlink created"
    else
        log_warning "ranger catppuccin: ✗ Symlink not found"
        ((errors++))
    fi
    
    if [[ $errors -eq 0 ]]; then
        log_success "All configurations deployed successfully!"
    else
        log_warning "$errors configuration(s) had issues"
    fi
}

# Main deployment function
main() {
    echo "🎨 Catppuccin Dotfiles Deployment Script"
    echo "========================================"
    
    detect_os
    check_dependencies
    
    # Ask for confirmation
    read -p "Deploy Catppuccin configurations for $OS? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Deployment cancelled"
        exit 0
    fi
    
    # Ask if tools should be installed
    read -p "Install required tools? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        install_tools
    fi
    
    apply_os_configs
    deploy_catppuccin
    verify_deployment
    
    echo
    echo "🎉 Deployment completed!"
    echo "Please restart your shell or run 'source ~/.zshrc' (or ~/.bashrc) to apply changes."
    echo
    echo "Available tools with Catppuccin theme:"
    echo "  • tmux, ranger, zsh/bash, bat, fzf, vim, git, eza, ripgrep, htop, lazygit, rmpc"
    echo
    echo "Enjoy your beautiful Catppuccin environment! 🌈"
}

# Run main function
main "$@"
