# Catppuccin Mocha theme for ranger
# Based on official Catppuccin Mocha color palette
# https://github.com/catppuccin/catppuccin

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class catppuccin_mocha(ColorScheme):
    progress_bar_color = 5

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
                if context.empty or context.error:
                    fg = 203  # red (catppuccin red)
                    bg = 24   # base (catppuccin base)
                if context.border:
                    fg = 147  # overlay2
                if context.media:
                    if context.image:
                        fg = 245  # pink
                    else:
                        fg = 250  # peach
                if context.container:
                    fg = 250  # peach
                if context.directory:
                    attr |= bold
                    fg = 137  # blue
                elif context.executable and not \
                        any((context.media, context.container,
                            context.fifo, context.socket)):
                    attr |= bold
                    fg = 166  # green
                if context.socket:
                    fg = 203  # mauve
                    attr |= bold
                if context.fifo or context.device:
                    fg = 249  # yellow
                    if context.device:
                        attr |= bold
                if context.link:
                    fg = context.good and 148 or 203  # teal or mauve
                if context.bad:
                    bg = 203  # red
                if context.tag_marker and not context.selected:
                    attr |= bold
                    if fg in (203, 250):
                        fg = 205  # text
                    else:
                        fg = 203  # red
                if not context.selected and context.cut:
                    fg = 24   # base
                    attr |= bold
                if context.main_column:
                    if context.selected:
                        attr |= bold
                    if context.marked:
                        attr |= bold
                        fg = 249  # yellow
                if context.badinfo:
                    if attr & reverse:
                        bg = 203  # red
                    else:
                        fg = 203  # red

            else:
                if context.empty or context.error:
                    fg = 203  # red
                if context.border:
                    fg = 108  # overlay0
                if context.media:
                    if context.image:
                        fg = 245  # pink
                    else:
                        fg = 250  # peach
                if context.container:
                    fg = 250  # peach
                if context.directory:
                    fg = 137  # blue
                elif context.executable and not \
                        any((context.media, context.container,
                            context.fifo, context.socket)):
                    fg = 166  # green
                if context.socket:
                    fg = 203  # mauve
                if context.fifo or context.device:
                    fg = 249  # yellow
                if context.link:
                    fg = context.good and 148 or 203  # teal or mauve
                if context.tag_marker and not context.selected:
                    attr |= bold
                    if fg in (203, 250):
                        fg = 205  # text
                    else:
                        fg = 203  # red
                if not context.selected and context.cut:
                    fg = 127  # overlay1
                if context.main_column:
                    if context.marked:
                        attr |= bold
                        fg = 249  # yellow
                if context.badinfo:
                    fg = 203  # red

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = context.bad and 203 or 166  # red or green
            elif context.directory:
                fg = 137  # blue
            elif context.tab:
                if context.good:
                    bg = 166  # green
            elif context.link:
                fg = 148  # teal

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 148  # teal
                elif context.bad:
                    fg = 203  # red
            if context.marked:
                attr |= bold | reverse
                fg = 249  # yellow
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = 203  # red
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = 137  # blue
                attr &= ~bold
            if context.vcscommit:
                fg = 249  # yellow
                attr &= ~bold

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = 137  # blue

            if context.selected:
                attr |= reverse

            if context.loaded:
                if context.selected:
                    fg = self.progress_bar_color
                else:
                    bg = self.progress_bar_color

        if context.vcsfile and not context.selected:
            attr &= ~bold
            if context.vcsconflicts:
                fg = 203  # red
            elif context.vcschanged:
                fg = 249  # yellow
            elif context.vcsunknown:
                fg = 203  # red
            elif context.vcsstaged:
                fg = 166  # green
            elif context.vcssync:
                fg = 166  # green
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync:
                fg = 166  # green
            elif context.vcsbehind:
                fg = 203  # red
            elif context.vcsahead:
                fg = 137  # blue
            elif context.vcsdiverged:
                fg = 203  # mauve
            elif context.vcsunknown:
                fg = 203  # red

        return fg, bg, attr
