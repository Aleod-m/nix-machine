local opts = { noremap = true, silent = true }

local km = require "utils.keymaps" 
local ctrl = km.ctrl
local leader = km.leader


km.mapleader " "
km.maplleader ","


km.set_keymaps {
    -- H/L to jump to the start/end of a line
    { mode="n", keymap="H", action="^" },
    { mode="v", keymap="H", action="^" },
    { mode="n", keymap="L", action="$" },
    { mode="v", keymap="L", action="$" },

    -- dH/dL to delete to the start/end of a line
    { mode="n", keymap="dH", action="d^" },
    { mode="v", keymap="dH", action="d^" },
    { mode="n", keymap="dL", action="d$" },
    { mode="v", keymap="dL", action="d$" },


    -- Remaps for my keyboard layout (workman-p)
    -- also move cursor in the column
    { mode="n", keymap="t", action="gk" },
    { mode="v", keymap="t", action="gk" },
    { mode="n", keymap="k", action="gj" },
    { mode="v", keymap="k", action="gj" },

    -- Source config.
    {
        mode="n",
        keymap= leader "o",
        action=":lua package.loaded.init = nil<CR> :luafile ~/.config/nvim/init.lua<CR>",
        opt={ noremap = true },
    },

    -- quick save
    { mode="n", keymap= leader "w", action=":w<CR>zR" },

    -- Nice feature to have for blocks languages
    { mode="i", keymap="{<CR>", action="{<CR>}<ESC>O" },
    { mode="i", keymap="[<CR>", action="[<CR>]<ESC>O" },
    { mode="i", keymap="(<CR>", action="(<CR>)<ESC>O" },

    -- Moving lines of text
    -- Insert mode with the ctrl key
    { mode="i", keymap= ctrl "k", action="<ESC>:m .+1<CR>==" },
    { mode="i", keymap= ctrl "t", action="<ESC>:m .-2<CR>==" },
    -- Normal mode with the ctrl key
    { mode="n", keymap= ctrl "k", action=":m .+1<CR>==" },
    { mode="n", keymap= ctrl "t", action=":m .-2<CR>==" },
    -- In visual mode with ctrl key
    { mode="v", keymap= ctrl "k", action=":m'>+<CR>gv=gv" },
    { mode="v", keymap= ctrl "t", action=":m-2<CR>gv=gv" },



    -- Clipboard integration
    { mode="n", keymap= leader "y", action="\"+y" },
    { mode="v", keymap= leader "y", action="\"+y" },
    { mode="n", keymap= leader "p", action="\"+p" },
    { mode="n", keymap= leader "P", action="\"+P" },
    { mode="n", keymap= leader "gp", action="'[v']" },


    -- Diagnostic
    { mode="n", keymap= leader "dn", action=vim.diagnostic.goto_next},
    { mode="n", keymap= leader "dp", action=vim.diagnostic.goto_prev},
    { mode="n", keymap= leader "e",  action=vim.diagnostic.open_float},
}

-- Modes added
require("keymaps.splits")
