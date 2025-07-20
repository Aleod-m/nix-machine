local km = require "core.keymaps"
local cmd = require 'core.cmd'

-- Set my leader to space
km.set("n", "<Space>", "<Nop>")
km.mapleader " "
-- Set my local leader to comma 
km.maplleader ","

local ctrl = km.ctrl
local alt = km.alt
local leader = km.leader


km.set_keymaps {
  -- Remaps for my keyboard layout (workman-p)
  { mode={"n", "v"}, keymap="t", action="gk" },
  { mode={"n", "v"}, keymap="k", action="gj" },

  -- H/L to jump to the start/end of a line 
  { mode={"n", "v"}, keymap="H", action="^" },
  { mode={"n", "v"}, keymap="L", action="$" },

  -- cH/cL
  { mode="n", keymap="cH", action="c^" },
  { mode="n", keymap="cL", action="c$" },

  -- dH/dL to delete to the start/end of a line
  { mode="n", keymap="dH", action="d^" },
  { mode="n", keymap="dL", action="d$" },

  -- yH/yL to yank to the start/end of a line
  { mode="n", keymap="yH", action="y^" },
  { mode="n", keymap="yL", action="y$" },

  -- Remap leader x to go to the black hole register.
  { mode={"n", "v"}, keymap=leader "x", action="\"_d" },

  -- Register yanking and pasting. 
  { mode={"n", "v"}, keymap= leader "y",  action="\"+y" },
  { mode={"n", "v"}, keymap= leader "p",  action="\"+p" },
  { mode={"n", "v"}, keymap= leader "P",  action="\"+P" },

  -- Select last paste.
  { mode="n", keymap= leader "vp", action="'[v']" },

  -- Remove highlights 
  { mode="n", keymap= leader "nh", action=cmd "noh" },

  -- quick save
  { mode="n", keymap= leader "w", action= cmd "w" },

  -- Nice feature to have for blocks languages
  { mode="i", keymap="{<CR>", action="{<CR>}<ESC>O" },
  { mode="i", keymap="[<CR>", action="[<CR>]<ESC>O" },
  { mode="i", keymap="(<CR>", action="(<CR>)<ESC>O" },

  -- Insert accents with alt k rather than ctrl k in insert mode.
  { mode="i", keymap= alt "k", action= ctrl "k" },

  -- Moving/Indenting lines of text
  -- Insert mode with the ctrl key
  { mode="i", keymap= ctrl "h", action="<C-D>" },
  { mode="i", keymap= ctrl "t", action="<C-O><Cmd>m .-2<CR>" },
  { mode="i", keymap= ctrl "k", action="<C-O><Cmd>m .+1<CR>"},
  { mode="i", keymap= ctrl "l", action="<C-T>" },

  -- Normal mode with the ctrl key
  { mode="n", keymap= ctrl "h", action="<<" },
  { mode="n", keymap= ctrl "t", action= cmd "m .-2" },
  { mode="n", keymap= ctrl "k", action= cmd "m .+1" },
  { mode="n", keymap= ctrl "l", action=">>" },

  -- In visual mode with ctrl key
  { mode="v", keymap= ctrl "h", action="<gv" },
  { mode="v", keymap= ctrl "k", action= (cmd "'<,'>m+") .. "gv"},
  { mode="v", keymap= ctrl "t", action= (cmd "'<,'>m-2") .. "gv" },
  { mode="v", keymap= ctrl "l", action=">gv" },

  -- Diagnostics
  { mode="n", keymap= leader "dn", action=function() vim.diagnostic.jump({count=1}) end },
  { mode="n", keymap= leader "dp", action=function() vim.diagnostic.jump({count=-1}) end },
  { mode="n", keymap= leader "dl", action= vim.diagnostic.open_float },

  -- Terminal 
  { mode="t", keymap= leader "<Esc>", action= cmd 'stopinsert'},
}
