local keymaps = require "keymaps"
local M = {}
-- Lsp Setup.
local opts = {
    tools = {
        hover_actions = {
            auto_focus = true,
        }
    },
    server = {
        on_attach = function()
            keymaps.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
            keymaps.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
            keymaps.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
            keymaps.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
            keymaps.set("n", "<leader>ca",  vim.lsp.buf.code_action, { buffer = 0 })
            keymaps.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
        end,
        capabilities = require 'languages.lsp.capabilities',
    }
}
require('rust-tools').setup(opts)

return M
