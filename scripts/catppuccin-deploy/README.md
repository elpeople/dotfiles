# Catppuccin Dotfiles Deployment Scripts

This directory contains scripts for deploying Catppuccin configurations across different environments.

## 🚀 Quick Start

### For any environment (macOS/Linux/WSL):
```bash
cd ~/dotfiles/scripts/catppuccin-deploy
chmod +x deploy.sh
./deploy.sh
```

### For Linux/WSL specific setup:
```bash
cd ~/dotfiles/scripts/catppuccin-deploy
chmod +x linux-wsl-setup.sh
./linux-wsl-setup.sh
./deploy.sh
```

## 📁 Scripts Overview

### `deploy.sh` - Main Deployment Script
- **Purpose**: Universal deployment script for all environments
- **Features**:
  - Automatic OS detection (macOS/Linux/WSL)
  - Dependency checking
  - Tool installation (optional)
  - Backup creation
  - Stow-based configuration deployment
  - Deployment verification

### `linux-wsl-setup.sh` - Linux/WSL Preparation
- **Purpose**: Install required packages and tools for Linux/WSL
- **Features**:
  - Distribution detection (Ubuntu/Debian/RHEL/CentOS/Fedora)
  - Package manager detection
  - Essential tool installation
  - WSL-specific configuration
  - Shell setup (Oh My Zsh, Powerlevel10k)

### `environment-configs.sh` - Environment Adjustments
- **Purpose**: Apply environment-specific configurations
- **Features**:
  - WSL clipboard integration
  - Linux clipboard setup
  - Environment-specific aliases

## 🎯 Supported Tools

The deployment scripts will configure Catppuccin themes for:

1. **tmux** - Terminal multiplexer
2. **ranger** - File manager
3. **zsh/bash** - Shell with syntax highlighting
4. **bat** - Cat replacement with syntax highlighting
5. **fzf** - Fuzzy finder
6. **vim** - Text editor
7. **git** - Version control with delta
8. **eza** - ls replacement
9. **ripgrep** - grep replacement
10. **htop** - Process monitor
11. **lazygit** - Git TUI
12. **rmpc** - Music player client

## 🌍 Environment Support

### macOS
- **Package Manager**: Homebrew
- **Tools**: All tools available via brew
- **Special Features**: Native clipboard integration

### Linux (Ubuntu/Debian)
- **Package Manager**: apt
- **Tools**: Most tools available via apt, some installed manually
- **Special Features**: xclip clipboard integration

### Linux (RHEL/CentOS/Fedora)
- **Package Manager**: yum/dnf
- **Tools**: Most tools available via package manager
- **Special Features**: xclip clipboard integration

### WSL (Windows Subsystem for Linux)
- **Package Manager**: apt (Ubuntu-based) or yum/dnf
- **Tools**: Linux tools + Windows clipboard integration
- **Special Features**: clip.exe integration for Windows clipboard

## 🔧 Manual Installation

If automatic installation fails, install these tools manually:

### Essential Tools
```bash
# Ubuntu/Debian
sudo apt install git stow zsh vim tmux ranger htop fzf ripgrep xclip

# RHEL/CentOS/Fedora
sudo yum install git stow zsh vim tmux ranger htop fzf ripgrep xclip

# macOS
brew install git stow zsh vim tmux ranger htop fzf ripgrep
```

### Additional Tools
- **bat**: `sudo apt install bat` or `brew install bat`
- **eza**: Download from GitHub releases
- **git-delta**: Download from GitHub releases
- **lazygit**: Download from GitHub releases
- **rmpc**: `cargo install rmpc` (requires Rust)

## 🛠️ Troubleshooting

### Common Issues

1. **Stow conflicts**:
   ```bash
   # Remove existing configs
   rm -rf ~/.config/bat ~/.config/fzf
   # Re-run deployment
   ./deploy.sh
   ```

2. **Missing tools**:
   ```bash
   # Run Linux/WSL setup first
   ./linux-wsl-setup.sh
   ```

3. **Permission issues**:
   ```bash
   # Make scripts executable
   chmod +x *.sh
   ```

4. **WSL clipboard not working**:
   - Ensure Windows clipboard is accessible
   - Check if `clip.exe` is in PATH

### Backup and Recovery

All deployments create automatic backups:
- **Location**: `~/catppuccin_backup_YYYYMMDD_HHMMSS/`
- **Contents**: Original configuration files
- **Recovery**: Copy files back from backup directory

## 📝 Customization

### Adding New Tools
1. Add tool configuration to `~/dotfiles/catppuccin/.config/`
2. Update `deploy.sh` to include the new tool
3. Test deployment

### Environment-Specific Settings
1. Edit `environment-configs.sh`
2. Add new environment detection
3. Apply specific configurations

## 🎉 Post-Deployment

After successful deployment:

1. **Restart shell**: `exec $SHELL` or open new terminal
2. **Source configurations**: `source ~/.zshrc` or `source ~/.bashrc`
3. **Test tools**: Try `bat`, `fzf`, `lazygit`, etc.
4. **Enjoy**: Beautiful Catppuccin theme across all tools!

## 📚 Additional Resources

- [Catppuccin Official](https://github.com/catppuccin/catppuccin)
- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/stow.html)
- [Dotfiles Best Practices](https://dotfiles.github.io/)

---

**Happy theming! 🎨**
