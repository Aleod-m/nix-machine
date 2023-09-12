return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true }
    }

    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local lsp = vim.lsp
        -- Lsp capabilities.
        lsp.capabilities = cmp_lsp.default_capabilities()
        -- Attach function.
        lsp.on_attach = function(client, bufnr)
            local km = require("utils.kemap")
            local opts = {noremap = true, silent = true, buffer = bufnr}
            km.set_keymaps({
                {mode = "n", key= "K", action = lsp.buf.hover, opts = opts } 
                {mode = "n", key= "gd", action = lsp.buf.definition, opts = opts }
                {mode = "n", key= "gT", action = lsp.buf.type_definition, opts = opts }
                {mode = "n", key= "gi", action = lsp.buf.implementation, opts = opts }
                {mode = "n", key= "<leader>ca",  action = lsp.buf.code_action, opts = opts }
                {mode = "n", key= "<leader>r", action = lsp.buf.rename, opts = opts }
            })
        end
    end
}
