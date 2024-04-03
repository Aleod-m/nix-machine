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
    config = function ()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, bufnr)
            -- you can also put keymaps in here
            vim.lsp.inlay_hint(bufnr, true)
          end,
          settings = function(project_root)
            local ra = require('rustaceanvim.config.server')
            return ra.load_rust_analyzer_settings(project_root, {
              settings_file_pattern = 'rust-analyzer.json'
            })
          end,
        },
      }
    end
  },
}
