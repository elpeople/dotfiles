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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# opencode
export PATH=/home/elpeople/.opencode/bin:$PATH
