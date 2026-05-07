# Dotfiles

Personal dotfiles managed with [ghq](https://github.com/x-motemen/ghq) and [GNU Stow](https://www.gnu.org/software/stow/).

This repository follows the **XDG Base Directory Specification** wherever possible, keeping your home directory clean by storing configurations in `~/.config/`.

## Prerequisites

- **ghq**: Repository management
- **GNU Stow**: Symlink management
- **Git**: Version control
- **Homebrew**: Package management (macOS)
- **zsh**: Primary shell
- **fzf**: Fuzzy finder (with Catppuccin theme)
- **bat**, **eza**, **ripgrep**, **zoxide**: Modern CLI tools

## Installation

1.  **Clone with ghq**:
    ```bash
    ghq get git@github.com:elpeople/dotfiles.git
    cd $(ghq list -p -m dotfiles)
    ```

2.  **Install tools via Homebrew**:
    Refer to [Casks.md](Casks.md) for a list of currently installed GUI applications and CLI tools.

3.  **Apply configurations with Stow**:
    ```bash
    # Install all core packages
    stow bash nb vim zsh starship tmux wezterm ranger fzf catppuccin -t ~
    ```

4.  **For detailed setup instructions**, refer to the [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md).

## Available Packages

-   **bash** / **zsh** - Shell configurations (zsh uses `zinit`)
-   **vim** / **nvim** - Editor configurations
-   **tmux** - Terminal multiplexer with TPM and Catppuccin theme
-   **wezterm** - WezTerm configuration with custom tab colors matching Ranger
-   **ranger** - File manager with Catppuccin Mocha theme
-   **nb** - Configuration for `nb` note-taking tool
-   **fzf** - Fuzzy finder themed with Catppuccin Mocha
-   **catppuccin** - Centralized Catppuccin theme configurations for various tools
-   **stow**, **starship**, **lazygit**, **local_bin**, **w3m**, **screen**

## Usage

### Navigation Aliases

Added convenient aliases for navigating dotfiles:
- `gcd`: Jump directly to the dotfiles repository.
- `g`: Interactively select any ghq-managed repository via fzf.

### Symlink Management (Stow)

```bash
# Navigate to dotfiles root
gcd

# Link a package
stow <package_name>

# Unlink a package
stow -D <package_name>
```

## Configuration Structure

Adheres to XDG standards:
```
package/
├── .config/           # Linked to ~/.config/
│   └── app/
└── .dotfile           # Linked to ~/
```

## Documentation
- [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md): Detailed tool setup.
- [Casks.md](Casks.md): List of Homebrew packages.
- [GEMINI.md](GEMINI.md): Project-specific instructions for AI assistants.

## Environment-Specific Configurations
Supports macOS, Linux, and WSL via `.zshrc.mac`, `.zshrc.lin`, etc.

## License
MIT License
