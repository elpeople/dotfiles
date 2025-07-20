# Setup fzf
# ---------
if [[ ! "$PATH" == */home/elpeople/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/elpeople/.fzf/bin"
fi

source <(fzf --zsh)
