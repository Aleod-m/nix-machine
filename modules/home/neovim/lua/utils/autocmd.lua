-- Help with setting autocmds
local augroup = require'utils.augroup'

local M = {}
--Create an autocmd.
--
--    Examples:
--    • event: "pat1,pat2,pat3",
--    • event: "pat1"
--    • event: { "pat1" }
--    • event: { "pat1", "pat2", "pat3" }
--    
--    Parameters: ~
--        {event}  The event or events to register this autocmd
--                 Required keys: event: string | ArrayOf(string)
--    
--    Parameters: ~
--        {opts}  Optional Parameters:
--                • callback: (string|function)
--                  • (string): The name of the viml function to
--                    execute when triggering this autocmd
--                  • (function): The lua function to execute when
--                    triggering this autocmd
--                  • NOTE: Cannot be used with {command}
--    
--                • command: (string) command
--                  • vimscript command
--                  • NOTE: Cannot be used with {callback} Eg.
--                    command = "let g:value_set = v:true"
--    
--                • pattern: (string|table)
--                  • pattern or patterns to match against
--                  • defaults to "*".
--                  • NOTE: Cannot be used with {buffer}
--    
--                • buffer: (bufnr)
--                  • create a |autocmd-buflocal| autocmd.
--                  • NOTE: Cannot be used with {pattern}
--    
--                • group: (string|int) The augroup name or id
--                • once: (boolean) - See |autocmd-once|
--                • nested: (boolean) - See |autocmd-nested|
--                • desc: (string) - Description of the autocmd
M.create = function(events, opts)
    local id = vim.api.nvim_create_autocmd(events, opts)
    M[id] = {
        events = events,
        opts = opts,
    }
    return id
end

M.delete = function(id)
    if M[id] == nil then 
        return
    end
    vim.api.nvim_del_autocmd(id)
end

return M
