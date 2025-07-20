#!/bin/bash
# Catppuccin Mocha theme for ripgrep

# Ripgrep color configuration with Catppuccin Mocha
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"

# Create ripgrep config file
cat > ~/.config/ripgrep/config << 'RGEOF'
# Catppuccin Mocha colors for ripgrep
--colors=match:fg:243,139,168
--colors=match:bg:49,50,68
--colors=match:style:bold
--colors=path:fg:137,180,250
--colors=path:style:bold
--colors=line:fg:249,226,175
--colors=column:fg:108,112,134

# Additional ripgrep settings
--smart-case
--follow
--hidden
--glob=!.git/*
--glob=!node_modules/*
--glob=!.cache/*
RGEOF

# Aliases for ripgrep
# Aliases for ripgrep
alias grep='rg'
alias rgi='rg -i'
alias rgf='rg --files'
