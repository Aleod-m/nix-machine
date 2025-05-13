local km = require "core.keymaps"

return {
  -- Load lsp configs
  { import = "aleod.plugins.lsp" },

  -- Splits.
  { 'mrjones2014/smart-splits.nvim', opts = {} },

  -- Plugins without specific configurations
  { 'RRethy/nvim-align',             cmd = "Align" },

  -- Comments
  { 'numToStr/Comment.nvim',         opts = {} },

  -- Markdown
  { 'Aleod-m/md.nvim',               enabled = false, opts = {} },

  -- Ts Diagnostics
  -- {
  --   'Aleod-m/ts-diagnostics.nvim',
  --   keys = {
  --     { km.leader "tc", require("ts-diagnostics").toggle }
  --   },
  -- },

  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {},
    keys = {
      {mode='n', km.leader "ql", function() require "persistence.nvim".load() end },
    }
  },
}
