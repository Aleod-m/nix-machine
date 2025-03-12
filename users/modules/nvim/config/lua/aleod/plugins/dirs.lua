local cmd = require'core.cmd'
return {
  'stevearc/oil.nvim',
  lazy = false,

  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { mode= 'n', '-',  cmd 'Oil' },
  },
  config = true,
}
