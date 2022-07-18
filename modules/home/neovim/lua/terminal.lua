local tt = require('toggleterm')
local Terminal = require('toggleterm.terminal').Terminal
local keymaps = require('keymaps')

tt.setup{
    shade_terminals = true,
    shell = "nu",
    on_open = function(term)
        vim.cmd("startinsert!")
        keymaps.set("n", "q", "<cmd>close<CR>")
    end
}

local scratchTerm = Terminal:new({
    direction = 'float',
    float_opts = {
        border = 'curved',
        winblend = 0,
    },
})

local verticalTerm = Terminal:new({
    direction = 'vertical'
})

local horizontalTerm = Terminal:new({
    direction = 'horizontal'
})

local keys = {
    -- Terminal mode intergration
    { mode="n", keymap="<leader>tt", action= function() scratchTerm:toggle() end },
}
keymaps.set_keymaps(keys)

function _G.set_terminal_keymaps()
    keymaps.set("t", "<Esc>", [[<C-\><C-n>]])
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
