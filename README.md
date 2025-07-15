# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

- GNU Stow
- Git

### Installing Stow

**Ubuntu/Debian:**
```bash
sudo apt install stow
```

**macOS:**
```bash
brew install stow
```

**Arch Linux:**
```bash
sudo pacman -S stow
```

## Installation

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Install all packages:
```bash
make install
```

Or install specific packages:
```bash
make install-zsh
make install-tmux
make install-vim
```

## Available Packages

- **bash** - Bash shell configuration
- **zsh** - Zsh shell configuration with zinit plugin manager
- **vim** - Vim editor configuration
- **tmux** - Terminal multiplexer configuration with TPM
- **i3** - i3 window manager configuration
- **ranger** - File manager configuration
- **wezterm** - WezTerm terminal emulator configuration
- **lazygit** - Lazygit configuration
- **local_bin** - Local binary scripts
- **w3m** - W3m web browser configuration
- **nvim** - Neovim configuration
- **screen** - GNU Screen configuration

## Usage

### Using Makefile

```bash
# Install all packages
make install

# Install specific package
make install-zsh

# Uninstall all packages
make uninstall

# Uninstall specific package
make uninstall-tmux

# Reinstall all packages
make reinstall

# List available packages
make list

# Show current status
make status

# Check for conflicts
make check

# Clean broken symlinks
make clean
```

### Using install script

```bash
# Install all packages
./install.sh install all

# Install specific package
./install.sh install zsh

# Uninstall specific package
./install.sh uninstall tmux

# Show status
./install.sh status

# List packages
./install.sh list
```

### Using Stow directly

```bash
# Install package
stow zsh

# Uninstall package
stow -D zsh

# Reinstall package
stow -R zsh

# Simulate (dry run)
stow -n zsh
```

## Package Details

### Zsh
- Modern shell configuration with zinit plugin manager
- Powerlevel10k theme
- Syntax highlighting and autosuggestions
- Environment-specific configurations (Linux, macOS, WSL, Windows)

### Tmux
- Terminal multiplexer with TPM (Tmux Plugin Manager)
- Custom key bindings (prefix: Ctrl+g)
- Catppuccin theme
- Session management and restoration
- Environment-specific configurations

### Vim/Neovim
- Modern editor configuration
- Plugin management with dein.vim (Vim) or lazy.nvim (Neovim)
- Language support and syntax highlighting

### i3
- Tiling window manager configuration
- Custom key bindings and workspace management

## Configuration Structure

Each package follows the standard Stow directory structure:

```
package/
├── .config/           # XDG config files
│   └── app/
│       └── config
├── .local/            # Local files
│   └── bin/
│       └── script
└── .dotfile           # Home directory dotfiles
```

## Environment-Specific Configurations

Some packages (zsh, tmux) include environment-specific configurations:

- `.zshrc.lin` - Linux
- `.zshrc.mac` - macOS
- `.zshrc.wsl` - Windows Subsystem for Linux
- `.zshrc.win` - Windows (Git Bash/MSYS2)

The main configuration file automatically detects the environment and sources the appropriate file.

## Troubleshooting

### Conflicts with existing files

If you have existing dotfiles, Stow will warn about conflicts. You can:

1. Backup existing files manually
2. Use the install script which offers automatic backup
3. Remove conflicting files and reinstall

### Broken symlinks

Clean up broken symlinks:
```bash
make clean
```

### Check for issues

Check for conflicts before installing:
```bash
make check
```

### Stow simulation

Test what Stow would do without making changes:
```bash
stow -n package_name
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the configuration
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.