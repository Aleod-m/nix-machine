local M = {}

function M.set(option, value)
    vim.o[option] = value
    M[option] = value
end

M.set_options = function(options)
    if type(options) ~= "table" then
        return
    end
    for k, v in pairs(options) do
        vim.o[k] = v
        M[k] = v
    end
end

function M.set_local(option, value)
    vim.bo[option] = value
end

return M
