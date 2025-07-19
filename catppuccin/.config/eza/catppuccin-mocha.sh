#!/bin/bash
# Catppuccin Mocha theme for eza

# Exa color configuration with Catppuccin Mocha
export EXA_COLORS="\
uu=38;2;148;226;213:\
gu=38;2;148;226;213:\
ur=38;2;249;226;175:\
uw=38;2;243;139;168:\
ux=38;2;166;227;161:\
ue=38;2;166;227;161:\
gr=38;2;249;226;175:\
gw=38;2;243;139;168:\
gx=38;2;166;227;161:\
tr=38;2;249;226;175:\
tw=38;2;243;139;168:\
tx=38;2;166;227;161:\
su=38;2;245;224;220:\
sf=38;2;245;224;220:\
xa=38;2;249;226;175:\
sn=38;2;205;214;244:\
sb=38;2;205;214;244:\
da=38;2;108;112;134:\
in=38;2;108;112;134:\
bl=38;2;108;112;134:\
hd=38;2;137;180;250:\
lp=38;2;148;226;213:\
cc=38;2;249;226;175:\
"

# Aliases for eza with catppuccin
alias ls='eza --color=always --group-directories-first'
alias ll='eza -la --color=always --group-directories-first'
alias la='eza -a --color=always --group-directories-first'
alias lt='eza -T --color=always'
alias l='eza -F --color=always --group-directories-first'
