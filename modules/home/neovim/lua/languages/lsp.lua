local lspconf = require"lspconfig"
local M = {}
function M.setup(settings) 
    if settings.lsp_name ~= nil then
        lspconf[settings.lsp_name].setup(settings.lsp_setup)
    end
end

return M

