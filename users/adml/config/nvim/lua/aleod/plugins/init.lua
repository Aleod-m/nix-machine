return {
  -- Load lsp configs
  { import = "aleod.plugins.lsp" },
  -- Load custom modes configurations
  { import = "aleod.plugins.modes" },

  -- Plugins without specific configurations
  { 'RRethy/nvim-align', cmd = "Align" },
  -- Comments
  { 'numToStr/Comment.nvim', opts = {} },
}
