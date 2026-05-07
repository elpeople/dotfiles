#!/bin/bash
# Catppuccin Mocha theme for fzf
# DEBUG: echo "FZF Theme Loading..."

export FZF_DEFAULT_OPTS="
  --color=bg+:#313244,bg:#1e1e2e,spinner:#89b4fa,hl:#f9e2af
  --color=fg:#ffffff,header:#f38ba8,info:#cba6f7,pointer:#cba6f7
  --color=marker:#89b4fa,fg+:#ffffff,prompt:#a6e3a1,hl+:#f9e2af
  --border=rounded
  --border-label=' fzf '
  --preview-window=border-rounded
  --prompt='∷ '
  --marker='▶'
  --pointer='◆'
  --separator='─'
  --scrollbar='│'
"
