# ~/.zshrc

# 共通設定
export EDITOR=nvim
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
