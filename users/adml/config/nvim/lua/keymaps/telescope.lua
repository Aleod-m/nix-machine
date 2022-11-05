local Hydra = require('hydra')
local cmd = require('utils.cmd')
local tl = require('telescope.builtins')

Hydra({
    name = "Splits",
    mode = "n", 
    body = "<Space>f",
    config = {
        timeout = false,
        invoke_on_body = true,
        hint = {
            border = 'rounded',
            position = 'middle'
        }
    },
    hint = [[ ]],
    heads = {
        {"F",},
        {"f",},
        {"b",},
        {"b",},
    },
})
