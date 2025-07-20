# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# 共通設定
# ============================================================================

# Load common aliases
if [ -f "$HOME/dotfiles/shell/aliases" ]; then
    source "$HOME/dotfiles/shell/aliases"
fi

# 基本設定
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=100000
HISTFILESIZE=200000
shopt -s checkwinsize

# 基本環境変数
export EDITOR=vim
export LANG=ja_JP.UTF-8
export PATH="$HOME/.fzf/bin:$HOME/.local/bin:$PATH"

# XDG Base Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/state"

# ranger_cd function
ranger_cd() {
  temp_file="$(mktemp -t ranger_cd.XXXXXXXXXX)"
  ranger --choosedir="$temp_file" -- "${@:-$PWD}"
  chosen_dir="$(<"$temp_file")"
  if [[ -n "$chosen_dir" && "$chosen_dir" != "$PWD" ]]; then
    cd -- "$chosen_dir"
  fi
  rm -f -- "$temp_file"
}

# Bind Ctrl-O to ranger_cd
if command -v ranger &> /dev/null; then
  # Bash interactiveモードでのみバインド
  if [[ $- == *i* ]]; then
    # デフォルトのCtrl+Oを上書きしてrangerにバインド
    bind '"\C-o": operate-and-get-next'  # デフォルトを保持
    bind -x '"\C-o": ranger_cd'          # rangerに再バインド
  fi
fi

# Catppuccin theme
if [[ -f ~/.config/bash/catppuccin-mocha.sh ]]; then
    source ~/.config/bash/catppuccin-mocha.sh
fi

if [[ -f ~/.config/fzf/catppuccin-mocha.sh ]]; then
    source ~/.config/fzf/catppuccin-mocha.sh
fi

if [[ -f ~/.config/eza/catppuccin-mocha.sh ]]; then
    source ~/.config/eza/catppuccin-mocha.sh
fi

if [[ -f ~/.config/ripgrep/catppuccin-mocha.sh ]]; then
    source ~/.config/ripgrep/catppuccin-mocha.sh
fi

# fzf integration
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# fzfの表示問題を解決するためのターミナル設定
export TERM=xterm-256color
export COLUMNS=$(tput cols)
export LINES=$(tput lines)

# zoxide
eval "$(zoxide init bash)"

# OS固有設定
# ============================================================================

# OS別設定ファイルを読み込み
if grep -qEi "(Microsoft|WSL)" /proc/version &>/dev/null; then
    [ -f "$HOME/dotfiles/bash/bashrc.wsl" ] && source "$HOME/dotfiles/bash/bashrc.wsl"
elif [[ "$(uname -s)" == "Linux" ]]; then
    [ -f "$HOME/dotfiles/bash/bashrc.lin" ] && source "$HOME/dotfiles/bash/bashrc.lin"
elif [[ "$(uname -s)" == "Darwin" ]]; then
    [ -f "$HOME/dotfiles/bash/bashrc.mac" ] && source "$HOME/dotfiles/bash/bashrc.mac"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
    [ -f "$HOME/dotfiles/bash/bashrc.win" ] && source "$HOME/dotfiles/bash/bashrc.win"
fi

# 共通の最終設定
# ============================================================================

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash