local opts = require('core.options')
opts.set({
    -- Set My shell as nushell TODO: Make 
    sh = "nu",
    -- allow unlimited undos.
    undofile = true,
    mouse = 'a',

    -- Indentation at 4 space by default
    tabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    autoindent = true,
    smartindent = true,

    -- search options.
    completeopt = {'menu','menuone','noselect'},
    incsearch = true,
    ignorecase = true,
    smartcase = true,
    gdefault = true,

    --see whitespace
    list=true,
    lcs= { tab="\\u258F\\u2E31", eol="\\u23CE", space="\\u2E31" },

    -- Relative Numbers on the side
    number = true,
    relativenumber = true,

    termguicolors = true,
    -- Set scrolloff to see bellow easily.
    scrolloff = 15,
    -- Disable swap files.
    swapfile = false,

    -- ?
    scl = "yes",

    -- Usefull options for reloading the buffers.
    autoread = true,
    ut = 1000, -- 1 sec without moving will triger CursorHold
})

-- Remove comments on new line with o in normal mode.
opts.get("formatoptions"):remove({'o'})
