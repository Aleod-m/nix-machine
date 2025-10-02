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
