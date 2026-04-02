#!/bin/bash

# Enhanced Dotfiles installation script using GNU Stow
# Supports OS-specific package selection and safe backup/restore.

set -e

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ---------------------------------------------------------
# 1. OS Detection Logic
# ---------------------------------------------------------
detect_os() {
    local os_name="unknown"
    if [[ "$OSTYPE" == "darwin"* ]]; then
        os_name="mac"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if grep -qi Microsoft /proc/version 2>/dev/null; then
            os_name="wsl"
        else
            os_name="lin"
        fi
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
        os_name="win"
    fi
    echo "$os_name"
}

CURRENT_OS=$(detect_os)

# ---------------------------------------------------------
# 2. Package Definitions
# ---------------------------------------------------------
# OSに関わらずインストールするもの
COMMON_PACKAGES=(
    "bash" "zsh" "vim" "nvim" "tmux" "ranger" "wezterm" "lazygit" 
    "local_bin" "fzf" "catppuccin" "screen" "zoxide" "eza" "bat" 
    "ripgrep" "yazi" "atuin" "delta" "dust" "mise"
)

# Mac固有のもの
MAC_PACKAGES=("aerospace" "borders")

# Linux固有のもの
LIN_PACKAGES=("i3" "w3m" "newsboat")

# WSL固有のもの
WSL_PACKAGES=("w3m")

# Windows(Git Bash等)固有のもの
WIN_PACKAGES=()

# 推奨パッケージの決定
get_recommended_packages() {
    local packages=("${COMMON_PACKAGES[@]}")
    case "$CURRENT_OS" in
        "mac") packages+=("${MAC_PACKAGES[@]}") ;;
        "lin") packages+=("${LIN_PACKAGES[@]}") ;;
        "wsl") packages+=("${WSL_PACKAGES[@]}") ;;
    esac
    echo "${packages[@]}"
}

# ---------------------------------------------------------
# 3. Helper Functions
# ---------------------------------------------------------
print_status() { echo -e "${BLUE}[INFO]${NC} $1"; }
print_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }

check_stow() {
    if ! command -v stow &> /dev/null; then
        print_error "GNU Stow is not installed. Please install it first."
        exit 1
    fi
}

backup_existing() {
    local package="$1"
    # stow -n (simulation mode) で衝突をチェック
    local conflicts=$(stow -n "$package" 2>&1 | grep "existing target" || true)
    
    if [[ -n "$conflicts" ]]; then
        print_warning "Found existing files for $package. Backing up..."
        local backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)_$package"
        mkdir -p "$backup_dir"
        
        echo "$conflicts" | while read -r line; do
            if [[ $line =~ existing\ target\ is\ (.+)\ but\ link\ target\ is ]]; then
                local file_path="${BASH_REMATCH[1]}"
                # ファイルがシンボリックリンクでない場合のみバックアップ
                if [[ -e "$file_path" && ! -L "$file_path" ]]; then
                    print_status "Backing up: $file_path"
                    # ディレクトリ構造を維持してコピー
                    mkdir -p "$backup_dir/$(dirname "$file_path")"
                    cp -r "$file_path" "$backup_dir/$file_path"
                    rm -rf "$file_path"
                elif [[ -L "$file_path" ]]; then
                    print_status "Removing existing symlink: $file_path"
                    rm "$file_path"
                fi
            fi
        done
        print_success "Backup created in: $backup_dir"
    fi
}

# ---------------------------------------------------------
# 4. Main Commands
# ---------------------------------------------------------
install_package() {
    local package="$1"
    if [[ ! -d "$package" ]]; then
        print_error "Package '$package' not found."
        return 1
    fi
    backup_existing "$package"
    if stow "$package"; then
        print_success "Installed: $package"
    else
        print_error "Failed: $package"
    fi
}

uninstall_package() {
    local package="$1"
    print_status "Uninstalling: $package"
    stow -D "$package" && print_success "Uninstalled: $package"
}

show_status() {
    print_status "OS: $CURRENT_OS"
    print_status "Current Status:"
    local all_known=("${COMMON_PACKAGES[@]}" "${MAC_PACKAGES[@]}" "${LIN_PACKAGES[@]}" "${WSL_PACKAGES[@]}")
    for pkg in $(ls -d */ | sed 's/\///'); do
        # .gitなどはスキップ
        [[ "$pkg" == "old" || "$pkg" == "scripts" || "$pkg" == "config" ]] && continue
        
        echo -n "  $pkg: "
        if stow -n "$pkg" 2>&1 | grep -q "WARNING: skipping"; then
            echo -e "${GREEN}installed (linked)${NC}"
        else
            echo -e "${YELLOW}not installed${NC}"
        fi
    done
}

show_help() {
    echo "Usage: $0 [command] [package|all]"
    echo "Commands:"
    echo "  install [pkg|all]   Install package(s) (with auto backup)"
    echo "  uninstall [pkg|all] Remove symlinks"
    echo "  list                List all packages in this directory"
    echo "  status              Show current installation status"
    echo "  help                Show this message"
    echo ""
    echo "Detected OS: $CURRENT_OS"
}

# ---------------------------------------------------------
# 5. Execution
# ---------------------------------------------------------
main() {
    check_stow
    local cmd="${1:-help}"
    local target="${2:-}"

    case "$cmd" in
        "install")
            if [[ "$target" == "all" ]]; then
                local pkgs=$(get_recommended_packages)
                for p in $pkgs; do install_package "$p"; done
            elif [[ -n "$target" ]]; then
                install_package "$target"
            else
                print_error "Specify package or 'all'"; exit 1
            fi
            ;;
        "uninstall")
            if [[ "$target" == "all" ]]; then
                local pkgs=$(get_recommended_packages)
                for p in $pkgs; do uninstall_package "$p"; done
            elif [[ -n "$target" ]]; then
                uninstall_package "$target"
            fi
            ;;
        "list")
            ls -d */ | sed 's/\///'
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
