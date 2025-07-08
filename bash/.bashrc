# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

echo "DEBUG: ~/.bashrc is being executed."

# Load OS-specific bashrc
if [ -n "$WSL_DISTRO_NAME" ]; then
    echo "DEBUG: Detected WSL environment."
    # WSL (Windows Subsystem for Linux)
    if [ -f "$HOME/dotfiles/bash/.bashrc.wsl" ]; then
        echo "DEBUG: Sourcing $HOME/dotfiles/bash/.bashrc.wsl"
        . "$HOME/dotfiles/bash/.bashrc.wsl"
    else
        echo "DEBUG: $HOME/dotfiles/bash/.bashrc.wsl not found."
    fi
elif [[ "$(uname -s)" == "Linux" ]]; then
    echo "DEBUG: Detected Generic Linux environment."
    # Generic Linux (not WSL)
    if [ -f "$HOME/dotfiles/bash/.bashrc.lin" ]; then
        echo "DEBUG: Sourcing $HOME/dotfiles/bash/.bashrc.lin"
        . "$HOME/dotfiles/bash/.bashrc.lin"
    else
        echo "DEBUG: $HOME/dotfiles/bash/.bashrc.lin not found."
    fi
elif [[ "$(uname -s)" == "Darwin" ]]; then
    echo "DEBUG: Detected macOS environment."
    # macOS
    if [ -f "$HOME/dotfiles/bash/.bashrc.mac" ]; then
        echo "DEBUG: Sourcing $HOME/dotfiles/bash/.bashrc.mac"
        . "$HOME/dotfiles/bash/.bashrc.mac"
    else
        echo "DEBUG: $HOME/dotfiles/bash/.bashrc.mac not found."
    fi
elif [[ "$(uname -s)" == "CYGWIN_NT"* || "$(uname -s)" == "MINGW"* ]]; then
    echo "DEBUG: Detected Windows (Cygwin/Git Bash) environment."
    # Windows (Cygwin or Git Bash)
    if [ -f "$HOME/dotfiles/bash/.bashrc.win" ]; then
        echo "DEBUG: Sourcing $HOME/dotfiles/bash/.bashrc.win"
        . "$HOME/dotfiles/bash/.bashrc.win"
    else
        echo "DEBUG: $HOME/dotfiles/bash/.bashrc.win not found."
    fi
else
    echo "DEBUG: Unknown OS detected: $(uname -s)"
fi
