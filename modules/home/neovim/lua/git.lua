local neogit = require('neogit')
local keymaps = require('keymaps')

keymaps.set("n", "<leader>gi", neogit.open)

neogit.setup{}

