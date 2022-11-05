local tt = require('toggleterm')
local Terminal = require('toggleterm.terminal').Terminal
local km = require('utils.keymaps')

local M = {}

tt.setup{
    shade_terminals = true,
    shell = "nu",
    on_open = function(term)
        vim.cmd("startinsert!")
    end
}

M.scratchTerm = Terminal:new({
    direction = 'float',
    float_opts = {
        border = 'curved',
        winblend = 0,
    },
})

M.verticalTerm = Terminal:new({
    direction = 'vertical'
})

M.horizontalTerm = Terminal:new({
    direction = 'horizontal'
})

km.set("n", km.leader "t", function() M.scratchTerm:toggle() end);


function M.set_terminal_keymaps()
    km.set("t", "<Esc>", [[<C-\><C-n>]])
end

vim.cmd('autocmd! TermOpen term://* lua require("terminal").set_terminal_keymaps()')

return M
