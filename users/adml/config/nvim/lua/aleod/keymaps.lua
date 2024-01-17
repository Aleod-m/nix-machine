local km = require "core.keymaps"

-- Set my leader to space
km.mapleader " "
-- Set my local leader to comma 
km.maplleader ","

local ctrl = km.ctrl
local alt = km.alt
local leader = km.leader

km.set_keymaps {
  -- H/L to jump to the start/end of a line 
  { mode="n", keymap="H", action="^" },
  { mode="v", keymap="H", action="^" },
  { mode="n", keymap="L", action="$" },
  { mode="v", keymap="L", action="$" },

  -- dH/dL to delete to the start/end of a line
  { mode="n", keymap="dH", action="d^" },
  { mode="n", keymap="dL", action="d$" },

  -- yH/yL to yank to the start/end of a line
  { mode="n", keymap="yH", action="y^" },
  { mode="n", keymap="yL", action="y$" },

  -- cH/cL
  { mode="n", keymap="cH", action="c^" },
  { mode="n", keymap="cL", action="c$" },

  -- Remove highlights 
  { mode="n", keymap= leader "nh", action="<cmd>noh<Cr>" },

  -- Remaps for my keyboard layout (workman-p)
  -- also move cursor in the column
  { mode="n", keymap="t", action="gk" },
  { mode="v", keymap="t", action="gk" },
  { mode="n", keymap="k", action="gj" },
  { mode="v", keymap="k", action="gj" },

  -- quick save
  { mode="n", keymap= leader "w", action=":w<CR>zR" },

  -- Nice feature to have for blocks languages
  { mode="i", keymap="{<CR>", action="{<CR>}<ESC>O" },
  { mode="i", keymap="[<CR>", action="[<CR>]<ESC>O" },
  { mode="i", keymap="(<CR>", action="(<CR>)<ESC>O" },

  {mode="i", keymap= alt "k", action= ctrl "k" },

    -- Moving lines of text
    -- Insert mode with the ctrl key
  { mode="i", keymap= ctrl "h", action="<C-D>" },
  { mode="i", keymap= ctrl "l", action="<C-T>" },
  { mode="i", keymap= ctrl "k", action="<ESC><Cmd>m .+1<CR>i"},
  { mode="i", keymap= ctrl "t", action="<ESC><Cmd>m .-2<CR>i" },

    -- Normal mode with the ctrl key
  { mode="n", keymap= ctrl "k", action="<Cmd>m .+1<CR>" },
  { mode="n", keymap= ctrl "t", action="<Cmd>m .-2<CR>" },
  { mode="n", keymap= ctrl "h", action="<<" },
  { mode="n", keymap= ctrl "l", action=">>" },

    -- In visual mode with ctrl key
  { mode="v", keymap= ctrl "k", action=":m'>+<CR>gv"},
  { mode="v", keymap= ctrl "t", action=":m-2<CR>gv" },
  { mode="v", keymap= ctrl "h", action="<gv" },
  { mode="v", keymap= ctrl "l", action=">gv" },

  -- Register 1 yanking and pasting. 
  -- Usefull when you want yank something delete something else and paste the firs.
  { mode="n", keymap= leader "y",  action="\"1y" },
  { mode="v", keymap= leader "y",  action="\"1y" },
  { mode="n", keymap= leader "p",  action="\"1p" },
  { mode="n", keymap= leader "p",  action="\"1p" },
  -- Clipboard integration
  { mode="n", keymap= leader "Y",  action="\"+y" },
  { mode="v", keymap= leader "Y",  action="\"+y" },
  { mode="n", keymap= leader "P",  action="\"+p" },
  { mode="n", keymap= leader "P",  action="\"+p" },
  { mode="n", keymap= leader "vp", action="'[v']" },


  -- Diagnostics
  { mode="n", keymap= leader "dn", action= vim.diagnostic.goto_next  },
  { mode="n", keymap= leader "dp", action= vim.diagnostic.goto_prev  },
  { mode="n", keymap= leader "dl",  action= vim.diagnostic.open_float }
}

local M = {}

M.lsp_keys = function(client, bufnr)
  local km = require("core.kemaps")
  local opts = {
    noremap = true,
    silent = true,
    buffer = bufnr 
  }
  km.set_keymaps({
    { mode = "n", key= "K",           action = lsp.buf.hover,           opts = opts },
    { mode = "n", key= "gd",          action = lsp.buf.definition,      opts = opts },
    { mode = "n", key= "gT",          action = lsp.buf.type_definition, opts = opts },
    { mode = "n", key= "gi",          action = lsp.buf.implementation,  opts = opts },
    { mode = "n", key= "<leader>ca",  action = lsp.buf.code_action,     opts = opts },
    { mode = "n", key= "<leader>r",   action = lsp.buf.rename,          opts = opts }
  })
end

return M
