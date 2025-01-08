return {
  -- Load lsp configs
  { import = "aleod.plugins.lsp" },

  -- Splits.
  { 'mrjones2014/smart-splits.nvim', opts = {} },

  -- Plugins without specific configurations
  { 'RRethy/nvim-align', cmd = "Align" },

  -- Comments
  { 'numToStr/Comment.nvim', opts = {} },
}
