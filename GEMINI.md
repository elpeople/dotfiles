# Project: Dotfiles

This repository manages user configuration files (dotfiles) for various tools.

## Core Conventions
- **Location**: Managed by `ghq` at `~/src/github.com/elpeople/dotfiles`.
- **Symlink Management**: Uses `GNU Stow` for symlinking configurations to the home directory and `~/.config`.
- **Standards**: Follows **XDG Base Directory Specification** wherever possible (storing configs in `.config/`).

## Workflows
- **Applying Changes**: Navigate to the repository root and run `stow <package_name>`.
  ```bash
  cd $(ghq list -p -m dotfiles)
  stow bash
  stow tmux
  ```
- **Adding New Configs**: Create a directory structure that mirrors the desired path from the home directory, then `stow` it.
