local lspconf = require"lspconfig"
local M = {}

function M.setup(settings) 
    if settings.lsp_name ~= nil then
        lspconf[settings.lsp_name].setup(settings.lsp_setup)
    end
end

function M.code_action()
    require'telescope.builtin'.lsp_code_action(require'telescope.themes'.get_cursor({}))
end
return M

