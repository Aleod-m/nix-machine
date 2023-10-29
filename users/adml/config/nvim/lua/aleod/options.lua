local M = {}
M.options = { 
    -- Set My shell as nushell
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
    completeopt = 'menu,menuone,noselect',
    incsearch = true,
    ignorecase = true,
    smartcase = true,
    gdefault = true,

    -- Relative Numbers on the side
    number = true,
    relativenumber = true,

    termguicolors = true,
    -- Set scrolloff to see bellow easily.
    scrolloff = 15,
    -- Folds
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",

    -- ?
    scl = "yes",

    -- Usefull options for reloading the buffers.
    autoread = true,
    ut = 1000, -- 1 sec without moving will triger CursorHold
}

require('core.options').set_options(M.options)

return M
