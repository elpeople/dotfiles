# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zinit
if [[ -s "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
fi

# Powerlevel10kをZinitでロード
zinit light romkatv/powerlevel10k

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 共通設定
# ============================================================================

# Load common aliases
if [ -f "$HOME/dotfiles/shell/aliases" ]; then
    source "$HOME/dotfiles/shell/aliases"
fi

# 基本環境変数
export EDITOR=vim
# LANGはOS固有設定で設定するため、ここではデフォルトのみ
export LANG=${LANG:-C.UTF-8}
export PATH="$HOME/.local/bin:$PATH"

# anyenv
if command -v anyenv &>/dev/null; then
  eval "$(anyenv init -)"
fi

# Catppuccin theme configuration
if [[ -f ~/.config/zsh/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ]]; then
    source ~/.config/zsh/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
fi

# Catppuccin LS colors
export LS_COLORS="di=38;2;137;180;250:fi=38;2;205;214;244:ln=38;2;148;226;213:ex=38;2;166;227;161:*.jpg=38;2;245;194;231:*.png=38;2;245;194;231:*.gif=38;2;245;194;231"

# FZF Catppuccin theme
if [[ -f ~/.config/fzf/catppuccin-mocha.sh ]]; then
    source ~/.config/fzf/catppuccin-mocha.sh
fi

# eza (exa successor)
if [[ -f ~/.config/eza/catppuccin-mocha.sh ]]; then
    source ~/.config/eza/catppuccin-mocha.sh
fi

# ripgrep
if [[ -f ~/.config/ripgrep/catppuccin-mocha.sh ]]; then
    source ~/.config/ripgrep/catppuccin-mocha.sh
fi

# fzf integration
# export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# OS固有設定
# ============================================================================

# OS別設定ファイルを読み込み
case "$(uname)" in
  Darwin)
    [ -f "$HOME/dotfiles/zsh/zshrc.mac" ] && source "$HOME/dotfiles/zsh/zshrc.mac"
    ;;
  Linux)
    if grep -qi Microsoft /proc/version 2>/dev/null; then
      [ -f "$HOME/dotfiles/zsh/zshrc.wsl" ] && source "$HOME/dotfiles/zsh/zshrc.wsl"
    else
      [ -f "$HOME/dotfiles/zsh/zshrc.lin" ] && source "$HOME/dotfiles/zsh/zshrc.lin"
    fi
    ;;
  MINGW*|MSYS*|CYGWIN*)
    [ -f "$HOME/dotfiles/zsh/zshrc.win" ] && source "$HOME/dotfiles/zsh/zshrc.win"
    ;;
esac

# キーバインド設定
# ============================================================================

# emacsモードを有効化
bindkey -e

# 基本的なemacsキーバインド
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^D' delete-char
bindkey '^H' backward-delete-char
bindkey '^K' kill-line
bindkey '^U' kill-whole-line
bindkey '^Y' yank
bindkey '^W' backward-kill-word

# Ctrl+O でranger起動
if command -v ranger &>/dev/null; then
  bindkey -s '^O' 'ranger^M'
fi

# 共通の最終設定
# ============================================================================

# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Rust
# export PATH="$HOME/.cargo/bin:$PATH"

# Load Catppuccin Powerlevel10k colors
if [[ -f ~/.config/zsh/p10k-catppuccin.zsh ]]; then
    source ~/.config/zsh/p10k-catppuccin.zsh
fi
