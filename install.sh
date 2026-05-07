#!/bin/bash

# Dotfiles installation script using GNU Stow
# Usage: ./install.sh [package_name] or ./install.sh all

set -e

# Detect script directory (the dotfiles root)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DOTFILES_DIR"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Available packages (automatically detect directories, excluding hidden and specific folders)
PACKAGES=($(ls -d */ | cut -f1 -d'/' | grep -vE '^(old|node_modules|ghost|syswatch|ghtest|backup)$'))

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if stow is installed
check_stow() {
    if ! command -v stow &> /dev/null; then
        print_error "GNU Stow is not installed. Please install it first."
        print_status "Ubuntu/Debian: sudo apt install stow"
        print_status "macOS: brew install stow"
        exit 1
    fi
}

# Function to backup existing files
backup_existing() {
    local package="$1"
    print_status "Checking for existing files for package: $package"
    
    # Use stow's simulation mode to check for conflicts
    # Note: we use -t ~ to target home directory explicitly
    if stow -n -t ~ "$package" 2>&1 | grep -q "existing target"; then
        print_warning "Found existing files that would conflict with $package"
        read -p "Do you want to backup existing files to ~/.dotfiles_backup? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            local backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
            mkdir -p "$backup_dir"
            
            # Extract conflicting files and backup
            stow -n -t ~ "$package" 2>&1 | grep "existing target" | while read -r line; do
                if [[ $line =~ existing\ target\ is\ (.+)\ but\ link\ target\ is ]]; then
                    local file="${BASH_REMATCH[1]}"
                    # Ensure path is absolute for removal/copying
                    [[ "$file" != /* ]] && file="$HOME/$file"
                    if [[ -e "$file" ]]; then
                        print_status "Backing up: $file"
                        # Create subdirectory structure in backup if needed
                        mkdir -p "$backup_dir/$(dirname "${file#$HOME/}")"
                        cp -r "$file" "$backup_dir/${file#$HOME/}"
                        rm -rf "$file"
                    fi
                fi
            done
            print_success "Backup created in: $backup_dir"
        else
            print_error "Cannot proceed without resolving conflicts"
            return 1
        fi
    fi
}

# Function to install a package
install_package() {
    local package="$1"
    
    if [[ ! -d "$package" ]]; then
        print_error "Package '$package' not found in $DOTFILES_DIR"
        return 1
    fi
    
    print_status "Installing package: $package"
    
    # Backup existing files if necessary
    backup_existing "$package" || return 1
    
    # Install the package
    if stow -v -t ~ "$package"; then
        print_success "Successfully installed: $package"
    else
        print_error "Failed to install: $package"
        return 1
    fi
}

# Function to uninstall a package
uninstall_package() {
    local package="$1"
    
    print_status "Uninstalling package: $package"
    
    if stow -D -t ~ "$package"; then
        print_success "Successfully uninstalled: $package"
    else
        print_error "Failed to uninstall: $package"
        return 1
    fi
}

# Function to reinstall a package
reinstall_package() {
    local package="$1"
    
    print_status "Reinstalling package: $package"
    uninstall_package "$package"
    install_package "$package"
}

# Function to list available packages
list_packages() {
    print_status "Available packages in $DOTFILES_DIR:"
    for package in "${PACKAGES[@]}"; do
        echo "  - $package"
    done
}

# Function to show help
show_help() {
    echo "Dotfiles management script using GNU Stow"
    echo ""
    echo "Current Location: $DOTFILES_DIR"
    echo ""
    echo "Usage: $0 [COMMAND] [PACKAGE]"
    echo ""
    echo "Commands:"
    echo "  install [package|all]    Install package(s)"
    echo "  uninstall [package|all]  Uninstall package(s)"
    echo "  reinstall [package|all]  Reinstall package(s)"
    echo "  list                     List available packages"
    echo "  status                   Show current stow status"
    echo "  help                     Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 install zsh           Install zsh configuration"
    echo "  $0 install all           Install all packages"
}

# Function to show status
show_status() {
    print_status "Current stow status (target: $HOME):"
    for package in "${PACKAGES[@]}"; do
        echo -n "  $package: "
        # Check if it's already stowed (if stow -n shows warnings about existing targets that ARE links, it might be stowed)
        if stow -n -t ~ "$package" 2>&1 | grep -q "existing target"; then
             echo -e "${GREEN}active/conflict${NC}"
        else
             echo -e "${YELLOW}not stowed${NC}"
        fi
    done
}

# Main script logic
main() {
    check_stow
    
    case "${1:-help}" in
        "install")
            if [[ "${2:-}" == "all" ]]; then
                for package in "${PACKAGES[@]}"; do
                    install_package "$package"
                done
            elif [[ -n "${2:-}" ]]; then
                install_package "$2"
            else
                print_error "Please specify a package name or 'all'"
                exit 1
            fi
            ;;
        "uninstall")
            if [[ "${2:-}" == "all" ]]; then
                for package in "${PACKAGES[@]}"; do
                    uninstall_package "$package"
                done
            elif [[ -n "${2:-}" ]]; then
                uninstall_package "$2"
            else
                print_error "Please specify a package name or 'all'"
                exit 1
            fi
            ;;
        "reinstall")
            if [[ "${2:-}" == "all" ]]; then
                for package in "${PACKAGES[@]}"; do
                    reinstall_package "$package"
                done
            elif [[ -n "${2:-}" ]]; then
                reinstall_package "$2"
            else
                print_error "Please specify a package name or 'all'"
                exit 1
            fi
            ;;
        "list")
            list_packages
            ;;
        "status")
            show_status
            ;;
        "help"|*)
            show_help
            ;;
    esac
}

main "$@"
