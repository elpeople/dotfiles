# Project: Dotfiles

This repository manages user configuration files (dotfiles) for various tools.

## Core Conventions
- **Location**: Managed by `ghq` at `~/src/github.com/elpeople/dotfiles`.
- **Symlink Management**: Uses `GNU Stow` for symlinking configurations to the home directory and `~/.config`.
- **Standards**: Follows **XDG Base Directory Specification** wherever possible (storing configs in `.config/`).

## Workflows
- **Applying Changes**: Navigate to the repository root and run `stow <package_name>` or use the included `install.sh`.
  ```bash
  cd $(ghq list -p -m dotfiles)
  ./install.sh install all
  ```
- **Script Specification (`install.sh`)**:
    - **Auto-Discovery**: Automatically detects top-level directories as packages (excludes `old`, `node_modules`, etc.).
    - **Backup**: Conflicting files in `~` are automatically moved to `~/.dotfiles_backup/`.
    - **Safety**: Always uses `-t ~` to ensure correct symlink targeting.

- **Adding New Configs**: Create a directory structure that mirrors the desired path from the home directory, then `stow` it.
