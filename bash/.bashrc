# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

echo "DEBUG: ~/.bashrc is being executed."

# Load common aliases
if [ -f "$HOME/dotfiles/shell/aliases" ]; then
    source "$HOME/dotfiles/shell/aliases"
fi

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

alias lg='lazygit'

# ranger_cd function for bash
ranger_cd() {
  temp_file="$(mktemp -t ranger_cd.XXXXXXXXXX)"
  ranger --choosedir="$temp_file" -- "${@:-$PWD}"
  chosen_dir="$(<"$temp_file")"
  if [[ -n "$chosen_dir" && "$chosen_dir" != "$PWD" ]]; then
    cd -- "$chosen_dir"
  fi
  rm -f -- "$temp_file"
}

# Bind Ctrl-O to ranger_cd in bash
if command -v ranger &> /dev/null; then
  bind -x '"\C-o": ranger_cd'
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH=~/.npm-global/bin:$PATH

# SSH自動起動
/usr/local/bin/start-ssh.sh

# Japanese Input Method (Mozc/IBus)
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# ロケール設定（日本語表示対応）
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# 日本語入力切り替え時にプロンプトをクリアする関数
clear_prompt_japanese() {
    # プロンプトをクリア
    printf '\033[2K\r'
    # 新しいプロンプトを表示
    if [ -n "$PS1" ]; then
        printf "$PS1"
    fi
}

# 入力メソッド切り替えのエイリアス
alias ime-ja='ibus engine mozc-jp && clear_prompt_japanese'
alias ime-en='ibus engine xkb:us::eng && clear_prompt_japanese'
alias ime-toggle='ibus engine $([ "$(ibus engine)" = "mozc-jp" ] && echo "xkb:us::eng" || echo "mozc-jp") && clear_prompt_japanese'

# Ctrl+Spaceで入力メソッド切り替え（ターミナル用）
bind '"\C-@": "ime-toggle\n"'

# Catppuccin Mocha theme
if [[ -f ~/.config/bash/catppuccin-mocha.sh ]]; then
    source ~/.config/bash/catppuccin-mocha.sh
fi

# FZF Catppuccin theme
if [[ -f ~/.config/fzf/catppuccin-mocha.sh ]]; then
    source ~/.config/fzf/catppuccin-mocha.sh
fi

# bat as cat replacement with catppuccin
alias cat='bat'
alias less='bat'

# fzf integration with bat preview
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# Additional CLI tools with Catppuccin
# eza (exa successor)
if [[ -f ~/.config/eza/catppuccin-mocha.sh ]]; then
    source ~/.config/eza/catppuccin-mocha.sh

fi

# ripgrep
if [[ -f ~/.config/ripgrep/catppuccin-mocha.sh ]]; then
    source ~/.config/ripgrep/catppuccin-mocha.sh
fi

# zoxide
eval "$(zoxide init bash)"alias pd='podcast-download.sh'
alias dawtalk='podcast-download.sh https://anchor.fm/daw-talk'
alias rebuild='podcast-download.sh https://rebuild.fm/'

# castero 起動エイリアス
alias castero='source ~/venv/castero/bin/activate && castero'
alias castero='~/.local/bin/castero-wrapper.sh'
