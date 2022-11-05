local keymaps = require"keymaps"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local M = {}
M.lsp_name = "sumneko_lua"
M.lsp_setup = {
    capabilities = require'languages.lsp.capabilities',
    on_attach = function()
        keymaps.set("n", "K", vim.lsp.buf.hover, {buffer = 0})
        keymaps.set("n", "gd", vim.lsp.buf.definition, {buffer = 0})
        keymaps.set("n", "gT", vim.lsp.buf.type_definition, {buffer = 0})
        keymaps.set("n", "gi", vim.lsp.buf.implementation, {buffer = 0})
        keymaps.set("n", "<leader>dn", vim.diagnostic.goto_prev, {buffer = 0})
        keymaps.set("n", "<leader>dp", vim.diagnostic.goto_next, {buffer = 0})
        keymaps.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", {buffer = 0})
        keymaps.set("n", "<leader>ca", "<cmd>Telescope lsp_code_actions<CR>", {buffer = 0})
        keymaps.set("n", "<leader>r", vim.lsp.buf.rename, {buffer = 0})
    end,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
return M
