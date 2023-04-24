local plugins = require("utils.plugins")

plugins.add({
    'saecki/crates.nvim',
    ft = "toml",
})

plugins.add({
    'rust-lang/rust.vim',
    ft = "rust",
})

plugins.add({
    'simrat39/rust-tools.nvim',
    denpendencies = "neovim/lsp-config",
    ft = "rust",
    config = {
        tools = {
            hover_actions = {
                auto_focus = true,
            }
        },
        server = {
            on_attach = require('languages.lsp').on_attach_fn 
            capabilities = require 'languages.lsp.capabilities',
        }
    },
})
