#!/bin/bash
# Linux/WSL specific Catppuccin setup script

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Detect if running in WSL
is_wsl() {
    grep -q Microsoft /proc/version 2>/dev/null
}

# Install packages for Ubuntu/Debian
install_ubuntu_packages() {
    log_info "Installing packages for Ubuntu/Debian..."
    
    # Update package list
    sudo apt update
    
    # Essential packages
    sudo apt install -y \
        curl \
        wget \
        git \
        stow \
        zsh \
        vim \
        tmux \
        ranger \
        htop \
        fzf \
        ripgrep \
        xclip \
        tree
    
    # Install bat (different package name on older Ubuntu)
    if apt list --installed 2>/dev/null | grep -q "bat/"; then
        log_success "bat already installed"
    else
        sudo apt install -y bat || sudo apt install -y batcat
    fi
    
    # Install exa/eza
    if ! command -v eza &> /dev/null; then
        if ! command -v exa &> /dev/null; then
            log_info "Installing exa..."
            sudo apt install -y exa
        fi
    fi
    
    log_success "Ubuntu/Debian packages installed"
}

# Install packages for RHEL/CentOS/Fedora
install_rhel_packages() {
    log_info "Installing packages for RHEL/CentOS/Fedora..."
    
    # Detect package manager
    if command -v dnf &> /dev/null; then
        PKG_MGR="dnf"
    elif command -v yum &> /dev/null; then
        PKG_MGR="yum"
    else
        log_warning "No supported package manager found"
        return 1
    fi
    
    # Install packages
    sudo $PKG_MGR install -y \
        curl \
        wget \
        git \
        stow \
        zsh \
        vim \
        tmux \
        ranger \
        htop \
        fzf \
        ripgrep \
        xclip \
        tree
    
    log_success "RHEL/CentOS/Fedora packages installed"
}

# Install additional tools manually
install_additional_tools() {
    log_info "Installing additional tools..."
    
    # Install git-delta
    if ! command -v delta &> /dev/null; then
        log_info "Installing git-delta..."
        DELTA_VERSION=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep -Po '"tag_name": "\K[^"]*')
        wget "https://github.com/dandavison/delta/releases/latest/download/delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
        tar -xzf "delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu.tar.gz"
        sudo mv "delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu/delta" /usr/local/bin/
        rm -rf "delta-${DELTA_VERSION}-x86_64-unknown-linux-gnu"*
        log_success "git-delta installed"
    fi
    
    # Install lazygit
    if ! command -v lazygit &> /dev/null; then
        log_info "Installing lazygit..."
        LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
        tar xf lazygit.tar.gz lazygit
        sudo install lazygit /usr/local/bin
        rm lazygit.tar.gz lazygit
        log_success "lazygit installed"
    fi
    
    # Install eza if exa is not available
    if ! command -v eza &> /dev/null && ! command -v exa &> /dev/null; then
        log_info "Installing eza..."
        EZA_VERSION=$(curl -s "https://api.github.com/repos/eza-community/eza/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
        wget "https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz"
        tar -xzf eza_x86_64-unknown-linux-gnu.tar.gz
        sudo mv eza /usr/local/bin/
        rm eza_x86_64-unknown-linux-gnu.tar.gz
        log_success "eza installed"
    fi
}

# Setup WSL-specific configurations
setup_wsl_config() {
    if is_wsl; then
        log_info "Setting up WSL-specific configurations..."
        
        # Ensure Windows clipboard integration
        if ! command -v clip.exe &> /dev/null; then
            log_warning "clip.exe not found. Windows clipboard integration may not work."
        else
            log_success "Windows clipboard integration available"
        fi
        
        # WSL-specific tmux configuration is already handled in dotfiles
        log_success "WSL configuration completed"
    fi
}

# Setup shell configurations
setup_shell() {
    log_info "Setting up shell configurations..."
    
    # Install oh-my-zsh if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    # Install powerlevel10k if not present
    if [[ ! -d "$HOME/powerlevel10k" ]]; then
        log_info "Installing Powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
    fi
    
    log_success "Shell setup completed"
}

# Main function
main() {
    echo "🐧 Linux/WSL Catppuccin Setup"
    echo "============================="
    
    if is_wsl; then
        log_info "Running in WSL environment"
    else
        log_info "Running in Linux environment"
    fi
    
    # Detect distribution
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        log_info "Detected distribution: $NAME"
        
        case $ID in
            ubuntu|debian)
                install_ubuntu_packages
                ;;
            rhel|centos|fedora)
                install_rhel_packages
                ;;
            *)
                log_warning "Unsupported distribution. Please install packages manually."
                ;;
        esac
    fi
    
    install_additional_tools
    setup_wsl_config
    setup_shell
    
    log_success "Linux/WSL setup completed!"
    log_info "Now run the main deployment script: ./deploy.sh"
}

main "$@"
