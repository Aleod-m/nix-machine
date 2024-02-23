return {
  {
    'saecki/crates.nvim',
    dependencies = "hrsh7th/nvim-cmp",
    ft = "toml",
    config = function(_, opts)
      local crates = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({ sources = {{ name = "crates" }} })
      crates.show()
    end
  },
  -- Rust lsp setup.
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    config = function ()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            -- you can also put keymaps in here
            vim.lsp.inlay_hint(bufnr, true)
          end,
        },
      }
    end
  },
}
