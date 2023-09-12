return {
    { 'saecki/crates.nvim', ft = "toml" },
    {
        'rust-lang/rust.vim',
        ft = "rust",
    },
    {
        'simrat39/rust-tools.nvim',
        ft = "rust",
        dependencies = "neovim/nvim-lspconfig",
        opts = {
            tools = {
                hover_actions = {
                    auto_focus = true,
                }
            },
            server = {
                on_attach = vim.lsp.on_attach,
                capabilities = vim.lsp.capabilities,
                check = { command = "clippy" },
                diagnostics = {
                    enable = true,
                    disabled = {"unresolved-proc-macro"},
                },
            },
        },
    }
}
