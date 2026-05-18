# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# 日本語ロケール
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# DOTFILES path
export DOTFILES=$HOME/src/github.com/elpeople/dotfiles

# echo "DEBUG: ~/.bashrc is being executed."

# Load common aliases
if [ -f "$DOTFILES/shell/aliases" ]; then
    source "$DOTFILES/shell/aliases"
fi

# Cargo and rmpc (from local)
. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"
alias rmpc="$HOME/.cargo/bin/rmpc"

# Load OS-specific bashrc
if [ -n "$WSL_DISTRO_NAME" ] || grep -q microsoft /proc/version 2>/dev/null; then
    # echo "DEBUG: Detected WSL environment."
    # WSL (Windows Subsystem for Linux)
    if [ -f "$DOTFILES/bash/.bashrc.wsl" ]; then
        # echo "DEBUG: Sourcing $DOTFILES/bash/.bashrc.wsl"
        . "$DOTFILES/bash/.bashrc.wsl"
    else
        echo "DEBUG: $DOTFILES/bash/.bashrc.wsl not found."
    fi
elif [[ "$(uname -s)" == "Linux" ]]; then
    # echo "DEBUG: Detected Generic Linux environment."
    # Generic Linux (not WSL)
    if [ -f "$DOTFILES/bash/.bashrc.lin" ]; then
        # echo "DEBUG: Sourcing $DOTFILES/bash/.bashrc.lin"
        . "$DOTFILES/bash/.bashrc.lin"
    else
        echo "DEBUG: $DOTFILES/bash/.bashrc.lin not found."
    fi
elif [[ "$(uname -s)" == "Darwin" ]]; then
    echo "DEBUG: Detected macOS environment."
    # macOS
    if [ -f "$DOTFILES/bash/.bashrc.mac" ]; then
        echo "DEBUG: Sourcing $DOTFILES/bash/.bashrc.mac"
        . "$DOTFILES/bash/.bashrc.mac"
    else
        echo "DEBUG: $DOTFILES/bash/.bashrc.mac not found."
    fi
elif [[ "$(uname -s)" == "CYGWIN_NT"* || "$(uname -s)" == "MINGW"* ]]; then
    echo "DEBUG: Detected Windows (Cygwin/Git Bash) environment."
    # Windows (Cygwin or Git Bash)
    if [ -f "$DOTFILES/bash/.bashrc.win" ]; then
        echo "DEBUG: Sourcing $DOTFILES/bash/.bashrc.win"
        . "$DOTFILES/bash/.bashrc.win"
    else
        echo "DEBUG: $DOTFILES/bash/.bashrc.win not found."
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

# --- Merged Changes Start ---

# ibus + mozc 日本語入力設定 (from local)
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export INPUT_METHOD=ibus

# ibus自動起動関数 (from local)
start_ibus() {
    if ! pgrep -x ibus-daemon >/dev/null; then
        echo "ibusを起動しています..."
        # D-Busセッションの確認
        if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
            eval $(dbus-launch --sh-syntax)
        fi
        ibus-daemon -drx &
        sleep 2
        ibus engine mozc-jp 2>/dev/null || true
        echo "ibus起動完了。Super+SpaceまたはCtrl+Shiftで日本語入力を切り替えできます。"
    else
        echo "ibusは既に起動しています。"
    fi
}

stop_ibus() {
    pkill ibus-daemon 2>/dev/null || true
    echo "ibusを停止しました。"
}

restart_ibus() {
    stop_ibus
    sleep 1
    start_ibus
}

# 入力メソッド切り替えのエイリアス (from remote)
clear_prompt_japanese() {
    # プロンプトをクリア
    printf '\033[2K\r'
    # 新しいプロンプトを表示
    if [ -n "$PS1" ]; then
        printf "$PS1"
    fi
}
alias ime-ja='ibus engine mozc-jp && clear_prompt_japanese'
alias ime-en='ibus engine xkb:us::eng && clear_prompt_japanese'
alias ime-toggle='ibus engine $([ "$(ibus engine)" = "mozc-jp" ] && echo "xkb:us::eng" || echo "mozc-jp") && clear_prompt_japanese'

# Ctrl+Spaceで入力メソッド切り替え（ターミナル用） (from remote)
bind '"\C-@": "ime-toggle\n"'

# Catppuccin Themes (from remote)
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

# Tool configurations (from remote)
alias cat='bat'
alias less='bat'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
eval "$(zoxide init bash)"

# Podcast aliases (from remote)
alias pd='podcast-download.sh'
alias dawtalk='podcast-download.sh https://anchor.fm/daw-talk'
alias rebuild='podcast-download.sh https://rebuild.fm/'

# Castero alias (from remote)
alias castero='~/.local/bin/castero-wrapper.sh'

# --- Merged Changes End ---
. "$HOME/.local/share/../bin/env"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# WSL Copy-Paste Aliases (wsl-copy-paste)
# Perfect clipboard integration between WSL and Windows
alias copy='powershell.exe -noprofile -command "$stdin = [Console]::OpenStandardInput(); $bytes = [System.IO.MemoryStream]::new(); $stdin.CopyTo($bytes); $text = [System.Text.Encoding]::UTF8.GetString($bytes.ToArray()); $text = $text -replace \"`n\", \"`r`n\"; Set-Clipboard -Value $text"'
alias paste='powershell.exe -noprofile -command "$text = Get-Clipboard -Raw; $bytes = [System.Text.Encoding]::UTF8.GetBytes($text); [Console]::OpenStandardOutput().Write($bytes, 0, $bytes.Length)" | tr -d "\r"'
export DOTFILES="$HOME/src/github.com/elpeople/dotfiles"
