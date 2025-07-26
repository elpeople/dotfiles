# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ~/.zshrc

# 共通設定
export EDITOR=vim
export PATH="$HOME/.local/bin:$PATH"

# zinit
if [[ -s "$HOME/.local/share/zinit/zinit.git/zinit.zsh" ]]; then
  source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
fi

# anyenv
if command -v anyenv &>/dev/null; then
  eval "$(anyenv init -)"
fi

# 日本語ロケール
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8



# Load common aliases
if [ -f "$HOME/dotfiles/shell/aliases" ]; then
    source "$HOME/dotfiles/shell/aliases"
fi

# 環境ごとの分岐
case "$(uname)" in
  Darwin)
    source ~/.zshrc.mac ;;
  Linux)
    if grep -qi Microsoft /proc/version 2>/dev/null; then
      source ~/.zshrc.wsl
    else
      source ~/.zshrc.lin
    fi ;;
  MINGW*|MSYS*|CYGWIN*)
    source ~/.zshrc.win ;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



export PATH="$HOME/.cargo/bin:$PATH"

# Atlassian CLI (acli) のエイリアス
#alias acli="/Users/elpeople/.local/share/acli/plugin/rovodev/atlassian_cli_rovodev"
# Catppuccin theme configuration
# Load Catppuccin syntax highlighting
if [[ -f ~/.config/zsh/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh ]]; then
    source ~/.config/zsh/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
fi

# Catppuccin LS colors
export LS_COLORS="di=38;2;137;180;250:fi=38;2;205;214;244:ln=38;2;148;226;213:ex=38;2;166;227;161:*.jpg=38;2;245;194;231:*.png=38;2;245;194;231:*.gif=38;2;245;194;231"

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load Catppuccin Powerlevel10k colors
if [[ -f ~/.config/zsh/p10k-catppuccin.zsh ]]; then
    source ~/.config/zsh/p10k-catppuccin.zsh
fi

# Ranger cd function
source ~/ranger_cd_function.sh
bindkey -s "^O" "ranger_cd\n"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/elpeople/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/elpeople/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/elpeople/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/elpeople/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

