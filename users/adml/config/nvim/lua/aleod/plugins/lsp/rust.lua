return {
    { 'saecki/crates.nvim'
    , dependencies = "hrsh7th/nvim-cmp"
    , ft = "toml"
    , config = function(_, opts)
            local crates = require('crates')
            crates.setup(opts)
            require('cmp').setup.buffer({
                sources = {{ name = "crates" }}
            })
            crates.show()
    end
    },
    -- Rust lsp setup.
    { 'simrat39/rust-tools.nvim'
    , ft = "rust"
    , dependencies = 
        { "neovim/nvim-lspconfig"
        , "hrsh7th/nvim-cmp"
        }
    , opts = 
        { tools = { hover_actions = { auto_focus = true } }
        , server = 
            { check = { command = "clippy" }
            , diagnostics = { enable = true }
            }
        }
    , config = function(_, opts)
        local rt = require('rust-tools')
        opts.server.on_attach = require('aleod.keymaps').lsp_keys
        opts.server.capabilities = vim.lsp.capabilities
        rt.setup(opts)
    end
    },
    { 'rust-lang/rust.vim'
    , ft = "rust"
    }
}