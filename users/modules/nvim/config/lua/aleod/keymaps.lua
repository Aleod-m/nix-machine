local km = require "core.keymaps"

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
  -- also move cursor in the column
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
  -- Usefull when you want yank something delete something else and paste the firs.
  -- I use the "p register but you can use any letter register.
  { mode={"n", "v"}, keymap= leader "y",  action="\"py" },
  { mode={"n", "v"}, keymap= leader "p",  action="\"pp" },

  -- Clipboard integration.
  { mode={"n", "v"}, keymap= leader "Y",  action="\"+y" },
  { mode={"n", "v"}, keymap= leader "P",  action="\"+p" },

  -- go to last paste.
  { mode="n", keymap= leader "vp", action="'[v']" },


  -- Remove highlights 
  { mode="n", keymap= leader "nh", action="<cmd>noh<Cr>" },

  -- quick save
  { mode="n", keymap= leader "w", action=":w<CR>zR" },

  -- Nice feature to have for blocks languages
  { mode="i", keymap="{<CR>", action="{<CR>}<ESC>O" },
  { mode="i", keymap="[<CR>", action="[<CR>]<ESC>O" },
  { mode="i", keymap="(<CR>", action="(<CR>)<ESC>O" },

  -- Insert accents with alt k rather than ctrl k in insert mode.
  { mode="i", keymap= alt "k", action= ctrl "k" },

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
  { mode="v", keymap= ctrl "k", action="<Cmd>m'>+<CR>gv"},
  { mode="v", keymap= ctrl "t", action="<Cmd>m-2<CR>gv" },
  { mode="v", keymap= ctrl "h", action="<gv" },
  { mode="v", keymap= ctrl "l", action=">gv" },

  -- Diagnostics
  { mode="n", keymap= leader "dn", action= vim.diagnostic.goto_next  },
  { mode="n", keymap= leader "dp", action= vim.diagnostic.goto_prev  },
  { mode="n", keymap= leader "dl",  action= vim.diagnostic.open_float }
}
