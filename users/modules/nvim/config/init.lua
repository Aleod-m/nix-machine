
---------------------------------------
----------------Options----------------
---------------------------------------

opt.set({
	sh = vim.env.SHELL,
	-- allow unlimited undos.
	undofile = true,
	mouse = 'a',

	-- Indentation at 4 space by default
	tabstop = 4,
	shiftwidth = 4,

	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()",
	foldenable = false,

	-- Keep indentation level on newline.
	autoindent = true,
	smartindent = true,

	-- search options.
	completeopt = {'menu','menuone','noselect'},
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
	-- Disable swap files.
	swapfile = false,

	-- Always have sign column.
	signcolumn = "yes",

  -- window border
  winborder = "rounded",

	-- Usefull options for reloading the buffers.
	autoread = true,
	-- 1 sec without moving will triger CursorHold
	ut = 1000,
})

-- Remove comments on new line with o in normal mode.
vim.opt.formatoptions:remove({'o'})

---------------------------------------
----------------Keymaps----------------
---------------------------------------

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

  -- Map ctrl+T to ctrl+O to use ctrl t for moving code.
  { mode="n", keymap= ctrl "O", action= ctrl "t" },

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
  { mode="v", keymap= ctrl "t", action= (cmd "'<,'>m .-2") .. "gv" },
  { mode="v", keymap= ctrl "k", action= (cmd "'<,'>m .1") .. "gv" },
  { mode="v", keymap= ctrl "l", action=">gv" },

  -- Diagnostics
  { mode="n", keymap= leader "dn", action=function() vim.diagnostic.jump({count=1}) end },
  { mode="n", keymap= leader "dp", action=function() vim.diagnostic.jump({count=-1}) end },
  { mode="n", keymap= leader "dl", action= vim.diagnostic.open_float },

  -- Terminal 
  { mode="t", keymap= leader "<Esc>", action= cmd 'stopinsert'},

  -- Special yanks
  { mode="n", keymap="gyp", action=function() vim.fn.setreg('"', vim.fn.expand("%")) end},
  { mode="n", keymap="gyP", action=function() vim.fn.setreg('"', vim.fn.expand("%:p")) end},
  { mode="n", keymap="gYp", action=function() vim.fn.setreg("+", vim.fn.expand("%")) end},
  { mode="n", keymap="gYP", action=function() vim.fn.setreg("+", vim.fn.expand("%:p")) end},
}

au("BufEnter", {
  callback = function(event)
    if vim.bo[event.buf].filetype ~= "help" then return end
    vim.cmd.wincmd('L')
    vim.cmd({cmd = 'wincmd',  args={'|'}, count=80})
  end
})

-- Add autocmd to try reloading all buffers on CursorHold.
au({"CursorHold", "CursorHoldI"}, {
  command = "checktime",
})

-- Equalize the splits if terminal get resized. 
au("VimResized", {
  command = "wincmd ="
})

-----------------------------------
----------------LSP----------------
-----------------------------------

-- Servers with default configuration
vim.lsp.enable({
  "phpactor",
  "nixd",
  "bashls",
  "ccls",
  "lua_ls",
  "elmls",
  "svelte",
  "wgsl_analyzer",
  "zls",
  "nushell",
  "csharp_ls",
  "gdscript",
  "pylsp",
  "ts_ls",
  "jdtls",
  "spectral",
  "rust_analyzer",
  "perlnavigator",
})

vim.g.fmt_on_save = false

-- Format buffer using lsp if fmt on save is enabled.
lau('BufWritePre', {
  callback = function(event)
    if vim.g.fmt_on_save then
      vim.lsp.buf.format({ bufnr = event.buf })
    end
  end,
})

lau("LspAttach", {
  callback = function(ev)
    -- Setup completions
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Tweak client settings
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client ~= nil then
      -- If inlay hints are available enable them.
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
      end
      -- Prefer treesitter highlights, disable lsp highlighting.
      client.server_capabilities.semanticTokensProvider = nil
    end

    local opts = { buffer = ev.buf }
    km.set_keymaps({
      { mode = 'n', keymap = 'gD',       action = vim.lsp.buf.declaration,     opt = opts, },
      { mode = 'n', keymap = 'gd',       action = vim.lsp.buf.definition,      opt = opts, },
      { mode = 'n', keymap = 'gr',       action = vim.lsp.buf.references,      opt = opts, },
      { mode = 'n', keymap = 'K',        action = vim.lsp.buf.hover,           opt = opts, },
      { mode = 'n', keymap = ctrl 'K',   action = vim.lsp.buf.signature_help,  opt = opts, },
      { mode = 'n', keymap = leader 'D', action = vim.lsp.buf.type_definition, opt = opts, },
      { mode = 'n', keymap = leader 'I', action = vim.lsp.buf.implementation,  opt = opts, },
      -- Format.
      {
        mode = 'n',
        keymap = leader 'F',
        action = function() vim.lsp.buf.format { async = true } end,
        opt = opts,
      },
      -- Toogle inlay_hints.
      {
        mode = 'n',
        keymap = leader 'ti',
        action = function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end,
        opt = opts
      },
      -- Toogle format on save.
      {
        mode = 'n',
        keymap = '<space>ft',
        action = function()
          vim.g.fmt_on_save = not vim.g.fmt_on_save
          local state = nil;
          if vim.g.fmt_on_save then
            state = "enabled."
          else
            state = "disabled."
          end
          print("Format on save " .. state)
        end,
        opt = opts,
      },
      { mode = 'n', keymap = leader 'rn', action = vim.lsp.buf.rename,      opt = opts, },
      { mode = 'n', keymap = leader 'ca', action = vim.lsp.buf.code_action, opt = opts, },
    })
  end
})


---------------------------------------
----------------Plugins----------------
---------------------------------------

--- Builtin
cmd [[packadd nvim.tohtml]]
cmd [[packadd nvim.undotree]]

--- External
vim.pack.add({
})
