# Catppuccin theme for ranger
# Based on Catppuccin Mocha color palette

from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *

class catppuccin(ColorScheme):
    progress_bar_color = 5

    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                attr = reverse
                if context.empty or context.error:
                    fg = 1  # red
                    bg = 0
                if context.border:
                    fg = 1
                if context.media:
                    if context.image:
                        fg = 13  # magenta
                    else:
                        fg = 9   # bright red
                if context.container:
                    fg = 9
                if context.directory:
                    attr |= bold
                    fg = 4   # blue
                elif context.executable and not \
                        any((context.media, context.container,
                            context.fifo, context.socket)):
                    attr |= bold
                    fg = 2   # green
                if context.socket:
                    fg = 5   # magenta
                    attr |= bold
                if context.fifo or context.device:
                    fg = 3   # yellow
                    if context.device:
                        attr |= bold
                if context.link:
                    fg = context.good and 6 or 5  # cyan or magenta
                if context.bad:
                    bg = 1   # red
                if context.tag_marker and not context.selected:
                    attr |= bold
                    if fg in (1, 9):
                        fg = 15  # white
                    else:
                        fg = 1   # red
                if not context.selected and context.cut:
                    fg = 0
                    attr |= bold
                if context.main_column:
                    if context.selected:
                        attr |= bold
                    if context.marked:
                        attr |= bold
                        fg = 3   # yellow
                if context.badinfo:
                    if attr & reverse:
                        bg = 1   # red
                    else:
                        fg = 1   # red

            else:
                if context.empty or context.error:
                    fg = 1   # red
                if context.border:
                    fg = 0   # black
                if context.media:
                    if context.image:
                        fg = 13  # magenta
                    else:
                        fg = 9   # bright red
                if context.container:
                    fg = 9
                if context.directory:
                    fg = 4   # blue
                elif context.executable and not \
                        any((context.media, context.container,
                            context.fifo, context.socket)):
                    fg = 2   # green
                if context.socket:
                    fg = 5   # magenta
                if context.fifo or context.device:
                    fg = 3   # yellow
                if context.link:
                    fg = context.good and 6 or 5  # cyan or magenta
                if context.tag_marker and not context.selected:
                    attr |= bold
                    if fg in (1, 9):
                        fg = 15  # white
                    else:
                        fg = 1   # red
                if not context.selected and context.cut:
                    fg = 8   # dark gray
                if context.main_column:
                    if context.marked:
                        attr |= bold
                        fg = 3   # yellow
                if context.badinfo:
                    fg = 1   # red

        elif context.in_titlebar:
            attr |= bold
            if context.hostname:
                fg = context.bad and 1 or 2  # red or green
            elif context.directory:
                fg = 4   # blue
            elif context.tab:
                if context.good:
                    bg = 2   # green
            elif context.link:
                fg = 6   # cyan

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = 6   # cyan
                elif context.bad:
                    fg = 1   # red
            if context.marked:
                attr |= bold | reverse
                fg = 3   # yellow
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = 1   # red
            if context.loaded:
                bg = self.progress_bar_color
            if context.vcsinfo:
                fg = 4   # blue
                attr &= ~bold
            if context.vcscommit:
                fg = 3   # yellow
                attr &= ~bold

        if context.text:
            if context.highlight:
                attr |= reverse

        if context.in_taskview:
            if context.title:
                fg = 4   # blue

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
                fg = 1   # red
            elif context.vcschanged:
                fg = 3   # yellow
            elif context.vcsunknown:
                fg = 1   # red
            elif context.vcsstaged:
                fg = 2   # green
            elif context.vcssync:
                fg = 2   # green
            elif context.vcsignored:
                fg = default

        elif context.vcsremote and not context.selected:
            attr &= ~bold
            if context.vcssync:
                fg = 2   # green
            elif context.vcsbehind:
                fg = 1   # red
            elif context.vcsahead:
                fg = 4   # blue
            elif context.vcsdiverged:
                fg = 5   # magenta
            elif context.vcsunknown:
                fg = 1   # red

        return fg, bg, attr
