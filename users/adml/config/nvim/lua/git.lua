--local neogit = require('neogit')
local km = require('utils.keymaps')

--km.set("n", "<leader>gi", neogit.open)

--neogit.setup{}
require ('gitsigns').setup {
    numhl = true,
    on_attach = function(bufnb)
    end,
}
