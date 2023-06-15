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
    dependencies = "neovim/nvim-lspconfig",
    ft = "rust",
    config = {
        tools = {
            hover_actions = {
                auto_focus = true,
            }
        },
        server = {
            on_attach = require('languages.lsp').on_attach_fn,
            capabilities = require('languages.lsp.capabilities'),
            check = { command = "clippy" },
            diagnostics = {
                enable = true,
                disabled = {"unresolved-proc-macro"},
            },
        },
    },
})

local M = {}

-- Lsp for rust is managed by the rust-tools plugin.
function M.setup_lsp() 
end

function M.setup_TS() 
    return "rust"
end

return M
