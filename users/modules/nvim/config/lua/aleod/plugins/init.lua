local leader = require('core.keymaps').leader
local cmd = require('core.cmd')
return {
  -- Load lsp configs
  { import = "aleod.plugins.lsp" },

  -- Splits.
  { 'mrjones2014/smart-splits.nvim', opts = {} },

  -- Plugins without specific configurations
  { 'RRethy/nvim-align', cmd = "Align" },

  -- Comments
  { 'numToStr/Comment.nvim', opts = {} },
  {
    "catgoose/nvim-colorizer.lua",
    enable = false,
    keys = {
      { mode = 'n', leader 'tc', cmd 'ColorizerToggle' },
      { mode = 'n', leader 'cr', cmd 'ColorizerReloadAllBuffers' },
    },
    --@type colorizer.config
    opts = {
      filetypes = {},
      user_commands = { "ColorizerToggle", "ColorizerReloadAllBuffers" },
      user_default_options = {
        css = true,
        mode = "virtualtext",
        virtualtext = "     ",
        virtualtext_inline = 'after',
        virtualtext_mode = "background",
      },
    },
  },
}
