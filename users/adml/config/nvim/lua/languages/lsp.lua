local plugins = require("utils.plugins")
local lspconf = require"lspconfig"

plugins.add({
    "neovim/nvim-lspconfig",
    config = function()
        local lsp = require'lspconfig'
        local languages = require('languages')
        for _, lang in ipairs(languages) do
            lang.setup_lsp()
        end
    end
})


local M = {}

M.on_attach_fn = function()
    local km = require("utils.keymaps")
    km.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    km.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    km.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    km.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
    km.set("n", "<leader>ca",  vim.lsp.buf.code_action, { buffer = 0 })
    km.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
end

function M.code_action()
    require'telescope.builtin'.lsp_code_action(require'telescope.themes'.get_cursor({}))
end

return M
