local M = {}

M.create = function(name, clear)
    local id = vim.api.nvim_create_augroup(name, {clear = clear})
    M[name] = {
        id = id,
        clear = clear,
    }
end

M.delete = function(name)
    for name, group in pairs(M) do
        if type(group) == 'table' and name == name then
            vim.api.nvim_del_augroup_by_id(group.id)
            return
        end
    end
end

M.create("test", true)
M.delete("test")

return M
