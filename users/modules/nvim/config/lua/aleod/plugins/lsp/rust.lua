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
          settings = function(project_root)
            local settings = require('rustaceanvim.config.server').load_rust_analyzer_settings(project_root, {
              settings_file_pattern = 'rust-analyzer.json'
            })
            settings.inlay_hint = { enable = true }
            return settings
          end,
        },
      }
    end
  },
}
