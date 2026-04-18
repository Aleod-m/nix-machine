local km = require "h.keymaps"
local cmd = require "h.cmd"

cmd [[packadd nvim.tohtml]]
cmd [[packadd nvim.undotree]]

return {
  -- Splits.
  { 'mrjones2014/smart-splits.nvim', opts = {} },

  -- Plugins without specific configurations
  { 'RRethy/nvim-align',             cmd = "Align" },

  -- Comments
  { 'numToStr/Comment.nvim',         opts = {} },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {},
    keys = {
      {mode='n', km.leader "ql", function() require "persistence".load() end },
    }
  },
}
