# Catppuccin Mocha theme for sketchybar

# Catppuccin Mocha color palette
export CATPPUCCIN_ROSEWATER=0xfff5e0dc
export CATPPUCCIN_FLAMINGO=0xfff2cdcd
export CATPPUCCIN_PINK=0xfff5c2e7
export CATPPUCCIN_MAUVE=0xffcba6f7
export CATPPUCCIN_RED=0xfff38ba8
export CATPPUCCIN_MAROON=0xffeba0ac
export CATPPUCCIN_PEACH=0xfffab387
export CATPPUCCIN_YELLOW=0xfff9e2af
export CATPPUCCIN_GREEN=0xffa6e3a1
export CATPPUCCIN_TEAL=0xff94e2d5
export CATPPUCCIN_SKY=0xff89dceb
export CATPPUCCIN_SAPPHIRE=0xff74c7ec
export CATPPUCCIN_BLUE=0xff89b4fa
export CATPPUCCIN_LAVENDER=0xffb4befe
export CATPPUCCIN_TEXT=0xffcdd6f4
export CATPPUCCIN_SUBTEXT1=0xffbac2de
export CATPPUCCIN_SUBTEXT0=0xffa6adc8
export CATPPUCCIN_OVERLAY2=0xff9399b2
export CATPPUCCIN_OVERLAY1=0xff7f849c
export CATPPUCCIN_OVERLAY0=0xff6c7086
export CATPPUCCIN_SURFACE2=0xff585b70
export CATPPUCCIN_SURFACE1=0xff45475a
export CATPPUCCIN_SURFACE0=0xff313244
export CATPPUCCIN_BASE=0xff1e1e2e
export CATPPUCCIN_MANTLE=0xff181825
export CATPPUCCIN_CRUST=0xff11111b

# SketchyBar Catppuccin theme
sketchybar --bar color=$CATPPUCCIN_BASE \
                 border_color=$CATPPUCCIN_SURFACE0 \
                 
sketchybar --default label.color=$CATPPUCCIN_TEXT \
                     icon.color=$CATPPUCCIN_BLUE \
                     background.color=$CATPPUCCIN_SURFACE0 \
                     background.border_color=$CATPPUCCIN_OVERLAY0
