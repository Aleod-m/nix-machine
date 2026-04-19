local km = require'h.keymaps'
local cmd = km.cmd
local M = {}
M.plugins = {  'gh:stevearc/oil.nvim' }
M.config = function()
  require'oil'.setup({})
  km.set( 'n', '-',  cmd 'Oil')
end
return M
