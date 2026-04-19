local M = {}
local km = require "h.keymaps"
local cmd = require "h.cmd"

cmd [[packadd nvim.tohtml]]
cmd [[packadd nvim.undotree]]

M.plugins = {
  'gh:mrjones2014/smart-splits.nvim',
  'gh:RRethy/nvim-align',
  'gh:numToStr/Comment.nvim',
  "gh:folke/persistence.nvim",
}

M.config = function()
  ---@diagnostic disable-next-line: missing-fields
  require'smart-splits'.setup({})
  require'Comment'.setup()
  require'persistence'.setup()
  -- {mode='n', km.leader "ql", function() require "persistence".load() end },
end

return M
