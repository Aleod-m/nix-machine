import utils.theme as theme 
## Documentation:
##   qute://help/configuring.html
##   qute://help/settings.html

## This is here so configs done via the GUI are still loaded.
## Remove it to not load settings done via the GUI.

config.load_autoconfig(False)

# Prefer dark theme by default.
c.colors.webpage.preferred_color_scheme = 'dark'
c.hints.chars = 'ashtgyneoi'
c.keyhint.blacklist = ['tg*', 'gt*', 'yn*', 'ny*']

palette = {
    'background': '#282a36',
    'background-alt': '#282a36', 
    'background-attention': '#181920',
    'border': '#282a36',
    'current-line': '#44475a',
    'selection': '#44475a',
    'foreground': '#f8f8f2',
    'foreground-alt': '#e0e0e0',
    'foreground-attention': '#ffffff',
    'comment': '#6272a4',
    'cyan': '#8be9fd',
    'green': '#50fa7b',
    'orange': '#ffb86c',
    'pink': '#ff79c6',
    'purple': '#bd93f9',
    'red': '#ff5555',
    'yellow': '#f1fa8c'
}

theme.set(c, palette)

## Aliases for commands. The keys of the given dictionary are the
## aliases, while the values are the commands they map to.
## Type: Dict
c.aliases = {'w': 'session-save', 'q': 'close', 'qa': 'quit', 'wq': 'quit --save', 'wqa': 'quit --save'}


# with (config.configdir / 'config_opts.yml').open() as f:
#     yaml_data = yaml.safe_load(f)
#
# for k, v in yaml_data.items():
#     config.set(k, v)

def bind(key, *commands):
    config.bind(key, ';;'.join(commands))

c.bindings.default = {}
c.bindings.commands = {
    'normal': {
        # Scroll (binds for my workman layout)
        'h': 'scroll left',
        't': 'scroll up',
        'k': 'scroll down',
        'l': 'scroll right',
        '<Ctrl-F>': 'scroll-page 0 1',
        '<Ctrl-B>': 'scroll-page 0 -1',
        '<Ctrl-D>': 'scroll-page 0 0.5',
        '<Ctrl-U>': 'scroll-page 0 -0.5',
        'G': 'scroll-to-perc',
        'gg': 'scroll-to-perc 0',

        # History
        'H': 'back',
        'L': 'forward',

        # Zoom
        '+': 'zoom-in',
        '-': 'zoom-out',
        '=': 'zoom',

        '.': 'cmd-repeat-last',
        # Search
        '/': 'cmd-set-text /',
        '?': 'cmd-set-text ?',
        ':': 'cmd-set-text :',
        'N': 'search-prev',
        'n': 'search-next',

        # Hinting
        'ff': 'hint',
        'fr': 'hint --rapid links tab-bg',
        'ft': 'hint inputs',
        'fi': 'hint images',
        'gi': 'hint inputs --first',
        'fd': 'hint links download',
        'fy': 'hint links yank',

        'FF': 'hint all tab',
        'FI': 'hint images tab',

        ## Tabs
        # Navigation
        '<Alt-1>': 'tab-focus 1',
        '<Alt-2>': 'tab-focus 2',
        '<Alt-3>': 'tab-focus 3',
        '<Alt-4>': 'tab-focus 4',
        '<Alt-5>': 'tab-focus 5',
        '<Alt-6>': 'tab-focus 6',
        '<Alt-7>': 'tab-focus 7',
        '<Alt-8>': 'tab-focus 8',
        '<Alt-9>': 'tab-focus 9',
        '<Alt-0>': 'tab-focus 10',
        '<Alt-m>': 'tab-mute',
        'gs': 'cmd-set-text -sr :tab-select',
        'gms': 'cmd-set-text -s :tab-move',
        '<space>n': 'tab-next',
        '<space>p': 'tab-prev',

        'O': 'cmd-set-text -s :open -t',

        'q': 'tab-close',
        'Q': 'tab-close -o',

        # Page actions
        'o': 'cmd-set-text -s :open',
        'r': 'reload',
        'R': 'reload -f',
        '<Ctrl-Alt-p>': 'print',
        '<Ctrl-N>': 'open -w',
        '<Ctrl-Q>': 'quit',
        'u': 'undo',
        'U': 'undo -w',

        # Restart and quit.
        '<space>w': 'session-save',
        '<Ctrl-Shift-R>': 'restart',
        'ZQ': 'quit',
        'ZZ': 'quit --save',

        # bookmark/quickmark
        'm': 'quickmark-save',
        'b': 'cmd-set-text -s :quickmark-load',
        'B': 'cmd-set-text -s :quickmark-load -t',
        '<Ctrl-Shift-B>': 'bookmark-add',
        'gB': 'cmd-set-text -s :bookmark-load -t',
        'gb': 'cmd-set-text -s :bookmark-load',
        'Sq': 'bookmark-list',
        'Sb': 'bookmark-list --jump',
        'gh': 'history',

        # Modes
        "'": 'mode-enter jump_mark',
        'i': 'mode-enter insert',
        'v': 'mode-enter caret',
        'V': 'mode-enter caret ;; selection-toggle --line',
        '`': 'mode-enter set_mark',
        '<Ctrl-V>': 'mode-enter passthrough',
        '<Escape>': 'clear-keychain ;; search ;; fullscreen --leave',

        ## To classify / remap
        'yD': 'yank domain -s',
        'yM': 'yank inline [{title}]({url:yank}) -s',
        'yP': 'yank pretty-url -s',
        'yT': 'yank title -s',
        'yY': 'yank -s',
        'yd': 'yank domain',
        'ym': 'yank inline [{title}]({url:yank})',
        'yp': 'yank pretty-url',
        'yt': 'yank title',
        'yy': 'yank',
        '<Return>': 'selection-follow',

        'gf': 'view-source',
        'wi': 'devtools',
        'wIf': 'devtools-focus',
        'wIh': 'devtools left',
        'wIj': 'devtools bottom',
        'wIk': 'devtools top',
        'wIl': 'devtools right',
        'wIw': 'devtools window',

        'ad': 'download-cancel',
        'cd': 'download-clear',
        'gd': 'download',

        # '<Ctrl-p>': 'tab-pin',
        # 'gD': 'tab-give',
        'gO': 'cmd-set-text :open -t -r {url:pretty}',
        'go': 'cmd-set-text :open {url:pretty}',
        'gu': 'navigate up',
        'tCH': 'config-cycle -p -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload',
        'tCh': 'config-cycle -p -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload',
        'tCu': 'config-cycle -p -u {url} content.cookies.accept all no-3rdparty never ;; reload',
        'tIH': 'config-cycle -p -u *://*.{url:host}/* content.images ;; reload',
        'tIh': 'config-cycle -p -u *://{url:host}/* content.images ;; reload',
        'tIu': 'config-cycle -p -u {url} content.images ;; reload',
        'tPH': 'config-cycle -p -u *://*.{url:host}/* content.plugins ;; reload',
        'tPh': 'config-cycle -p -u *://{url:host}/* content.plugins ;; reload',
        'tPu': 'config-cycle -p -u {url} content.plugins ;; reload',
        'tSH': 'config-cycle -p -u *://*.{url:host}/* content.javascript.enabled ;; reload',
        'tSh': 'config-cycle -p -u *://{url:host}/* content.javascript.enabled ;; reload',
        'tSu': 'config-cycle -p -u {url} content.javascript.enabled ;; reload',
        'tcH': 'config-cycle -p -t -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload',
        'tch': 'config-cycle -p -t -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload',
        'tcu': 'config-cycle -p -t -u {url} content.cookies.accept all no-3rdparty never ;; reload',
        'tiH': 'config-cycle -p -t -u *://*.{url:host}/* content.images ;; reload',
        'tih': 'config-cycle -p -t -u *://{url:host}/* content.images ;; reload',
        'tiu': 'config-cycle -p -t -u {url} content.images ;; reload',
        'tpH': 'config-cycle -p -t -u *://*.{url:host}/* content.plugins ;; reload',
        'tph': 'config-cycle -p -t -u *://{url:host}/* content.plugins ;; reload',
        'tpu': 'config-cycle -p -t -u {url} content.plugins ;; reload',
        'tsH': 'config-cycle -p -t -u *://*.{url:host}/* content.javascript.enabled ;; reload',
        'tsh': 'config-cycle -p -t -u *://{url:host}/* content.javascript.enabled ;; reload',
        'tsu': 'config-cycle -p -t -u {url} content.javascript.enabled ;; reload',
        '{{': 'navigate prev -t',
        '}}': 'navigate next -t',
    },
    'caret': {
        'h': 'move-to-prev-char',
        't': 'move-to-prev-line',
        'k': 'move-to-next-line',
        'l': 'move-to-next-char',

        'H': 'move-to-end-of-line',
        'L': 'move-to-start-of-line',

        '<Ctrl-h>': 'scroll left',
        '<Ctrl-t>': 'scroll up',
        '<Ctrl-k>': 'scroll down',
        '<Ctrl-l>': 'scroll right',

        '<Ctrl-Space>': 'selection-drop',
        '<Escape>': 'mode-leave',
        '<Return>': 'yank selection',
        '<Space>': 'selection-toggle',
        'G': 'move-to-end-of-document',
        'V': 'selection-toggle --line',
        'Y': 'yank selection -s',
        '[': 'move-to-start-of-prev-block',
        ']': 'move-to-start-of-next-block',
        'b': 'move-to-prev-word',
        'c': 'mode-enter normal',
        'e': 'move-to-end-of-word',
        'gg': 'move-to-start-of-document',
        'o': 'selection-reverse',
        'v': 'selection-toggle',
        'w': 'move-to-next-word',
        'y': 'yank selection',
        '{': 'move-to-end-of-prev-block',
        '}': 'move-to-end-of-next-block',
    },
    'command': {
        '<Ctrl-Shift-r>': 'command-history-next',
        '<Ctrl-r>': 'command-history-prev',
        '<Ctrl-n>': 'completion-item-focus next',
        '<Ctrl-p>': 'completion-item-focus prev',

        '<Escape>': 'mode-leave',
        '<Return>': 'command-accept',
        # Todo
        '<Alt-B>': 'rl-backward-word',
        '<Alt-Backspace>': 'rl-backward-kill-word',
        '<Alt-D>': 'rl-kill-word',
        '<Alt-F>': 'rl-forward-word',
        '<Ctrl-?>': 'rl-delete-char',
        '<Ctrl-A>': 'rl-beginning-of-line',
        '<Ctrl-B>': 'rl-backward-char',
        '<Ctrl-E>': 'rl-end-of-line',
        '<Ctrl-F>': 'rl-forward-char',
        '<Ctrl-H>': 'rl-backward-delete-char',
        '<Ctrl-K>': 'rl-kill-line',
        '<Ctrl-Shift-W>': 'rl-filename-rubout',
        '<Ctrl-U>': 'rl-unix-line-discard',
        '<Ctrl-W>': 'rl-rubout " "',
        '<Ctrl-Y>': 'rl-yank',

        # '<Ctrl-C>': 'completion-item-yank',
        # '<Ctrl-D>': 'completion-item-del',
        # '<Ctrl-Return>': 'command-accept --rapid',
        # '<Ctrl-Shift-C>': 'completion-item-yank --sel',
        # '<Ctrl-Shift-Tab>': 'completion-item-focus prev-category',
        # '<Ctrl-Tab>': 'completion-item-focus next-category',
        # '<Down>': 'completion-item-focus --history next',
        # '<PgDown>': 'completion-item-focus next-page',
        # '<PgUp>': 'completion-item-focus prev-page',
        # '<Shift-Delete>': 'completion-item-del',
        # '<Up>': 'completion-item-focus --history prev',
    },
    'hint': {
        '<Ctrl-B>': 'hint all tab-bg',
        '<Ctrl-F>': 'hint links',
        '<Ctrl-R>': 'hint --rapid links tab-bg',
        '<Escape>': 'mode-leave',
        '<Return>': 'hint-follow',
    },
    'insert': {
        '<Ctrl-E>': 'edit-text',
        '<Escape>': 'mode-leave',
        '<Shift-Escape>': 'fake-key <Escape>',
        '<Shift-Ins>': 'insert-text -- {primary}',
    },
    'passthrough': {
        '<Shift-Escape>': 'mode-leave',
    },
    'prompt': {
        '<Alt-B>': 'rl-backward-word',
        '<Alt-Backspace>': 'rl-backward-kill-word',
        '<Alt-D>': 'rl-kill-word',
        '<Alt-E>': 'prompt-fileselect-external',
        '<Alt-F>': 'rl-forward-word',
        '<Alt-Shift-Y>': 'prompt-yank --sel',
        '<Alt-Y>': 'prompt-yank',
        '<Ctrl-?>': 'rl-delete-char',
        '<Ctrl-A>': 'rl-beginning-of-line',
        '<Ctrl-B>': 'rl-backward-char',
        '<Ctrl-E>': 'rl-end-of-line',
        '<Ctrl-F>': 'rl-forward-char',
        '<Ctrl-H>': 'rl-backward-delete-char',
        '<Ctrl-K>': 'rl-kill-line',
        '<Ctrl-P>': 'prompt-open-download --pdfjs',
        '<Ctrl-Shift-W>': 'rl-filename-rubout',
        '<Ctrl-U>': 'rl-unix-line-discard',
        '<Ctrl-W>': 'rl-rubout " "',
        '<Ctrl-X>': 'prompt-open-download',
        '<Ctrl-Y>': 'rl-yank',
        '<Down>': 'prompt-item-focus next',
        '<Escape>': 'mode-leave',
        '<Return>': 'prompt-accept',
        '<Shift-Tab>': 'prompt-item-focus prev',
        '<Tab>': 'prompt-item-focus next',
        '<Up>': 'prompt-item-focus prev',
    },
    'register': {
        '<Escape>': 'mode-leave',
    },
    'yesno': {
        '<Alt-Shift-Y>': 'prompt-yank --sel',
        '<Alt-Y>': 'prompt-yank',
        '<Escape>': 'mode-leave',
        '<Return>': 'prompt-accept',
        'N': 'prompt-accept --save no',
        'Y': 'prompt-accept --save yes',
        'n': 'prompt-accept no',
        'y': 'prompt-accept yes',
    },
}
