# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

- GNU Stow
- Git
- Homebrew (macOS/Linux) or scoop (Windows)
- zsh (recommended as main shell)
- bash
- vim or neovim
- zoxide
- bat
- eza
- ripgrep
- rmpc
- fzf

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

1.  Clone this repository:
    ```bash
    git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
    cd ~/dotfiles
    ```

2.  **For detailed installation instructions, especially for tools not managed by `stow` or requiring additional setup, please refer to the [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md).**

3.  Install all packages using `make`:
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

-   **bash** - Bash shell configuration
-   **zsh** - Zsh shell configuration with zinit plugin manager
-   **vim** - Vim editor configuration
-   **tmux** - Terminal multiplexer configuration with TPM
-   **i3** - i3 window manager configuration
-   **ranger** - File manager configuration
-   **wezterm** - WezTerm terminal emulator configuration
-   **lazygit** - Lazygit configuration
-   **local_bin** - Local binary scripts
-   **w3m** - W3m web browser configuration
-   **nvim** - Neovim configuration
-   **screen** - GNU Screen configuration
-   **zoxide** - A smarter `cd` command
-   **bat** - A `cat` clone with syntax highlighting and Git integration
-   **eza** - A modern `ls` replacement
-   **ripgrep** - A fast line-oriented search tool
-   **rmpc** - A terminal-based MPD client

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
-   Modern shell configuration with `zinit` plugin manager.
-   **Powerlevel10k** theme for a highly customizable and fast prompt.
-   Syntax highlighting and autosuggestions.
-   Environment-specific configurations (Linux, macOS, WSL, Windows).
-   Integrated with `zoxide` for smart directory navigation.

### Tmux
-   Terminal multiplexer with TPM (Tmux Plugin Manager).
-   Custom key bindings (prefix: Ctrl+g).
-   **Catppuccin** theme for a consistent look.
-   Session management and restoration.
-   Environment-specific configurations.

### Vim/Neovim
-   Modern editor configuration.
-   Plugin management with `dein.vim` (Vim) or `lazy.nvim` (Neovim).
-   Language support and syntax highlighting.
-   **Catppuccin** theme for a consistent look, with transparency settings.

### i3
-   Tiling window manager configuration.
-   Custom key bindings and workspace management.

### Ranger
-   File manager configuration.

### Wezterm
-   WezTerm terminal emulator configuration.

### Lazygit
-   Lazygit configuration.

### W3m
-   W3m web browser configuration.

### Zoxide
-   A smarter `cd` command that learns your habits.
-   Seamlessly integrated with `fzf` for interactive directory selection.

### Bat
-   A `cat` clone with syntax highlighting and Git integration.
-   Configured to use **Catppuccin** colors.

### Eza
-   A modern `ls` replacement with more features and better defaults.
-   Configured to use **Catppuccin** colors.

### Ripgrep
-   A fast line-oriented search tool.
-   Configured to use **Catppuccin** colors.

### Rmpc
-   A terminal-based MPD (Music Player Daemon) client.
-   Configured to use **Catppuccin** colors.

## Catppuccin Theme Integration

This dotfiles repository heavily utilizes the **Catppuccin** theme across various tools for a consistent and aesthetically pleasing terminal experience.

-   **Vim/Neovim:** Configured with `catppuccin_mocha` colorscheme and transparency.
-   **Powerlevel10k:** Custom color definitions to match the Catppuccin palette.
-   **LS_COLORS:** Environment variable set to apply Catppuccin colors to `ls` output.
-   **FZF:** Themed with Catppuccin colors for interactive selection.
-   **Bat:** Uses Catppuccin for syntax highlighting.
-   **Eza:** Displays directory listings with Catppuccin colors.
-   **Ripgrep:** Search results are colored with Catppuccin.
-   **Rmpc:** The terminal MPD client uses the Catppuccin palette.
-   **Tmux:** Configured with Catppuccin theme.

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

Some packages (zsh, tmux, bash) include environment-specific configurations:

-   `.zshrc.lin` / `.bashrc.lin` - Linux
-   `.zshrc.mac` / `.bashrc.mac` - macOS
-   `.zshrc.wsl` / `.bashrc.wsl` - Windows Subsystem for Linux
-   `.zshrc.win` / `.bashrc.win` - Windows (Git Bash/MSYS2)

The main configuration file automatically detects the environment and sources the appropriate file.

## Troubleshooting

### Conflicts with existing files

If you have existing dotfiles, Stow will warn about conflicts. You can:

1.  Backup existing files manually
2.  Use the install script which offers automatic backup
3.  Remove conflicting files and reinstall

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

1.  Fork the repository
2.  Create a feature branch
3.  Make your changes
4.  Test the configuration
5.  Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
