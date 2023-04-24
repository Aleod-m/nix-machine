local plugins = require("utils.plugins")

plugins.add({
    "L3MON4D3/LuaSnip",
})

local M = {}
local km = require("utils.keymaps")
local ls = require("luasnip")

M.expand = function()
    if ls.expandable() then
        ls.expand()
    end
end

M.jump_next = function()
    if ls.jumpable() then
        ls.jump()
    end
end

M.jump_prev =  function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end

M.change_choice =  function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end

km.set_keymaps {
    { -- My expand key
        mode = {"i", "s"},
        keymap = km.ctrl "e",
        action = M.expand
    },
    { -- My next key to move in the snippet
        mode = "i",
        keymap = km.ctrl "n",
        action = M.jump_next
    },
    { -- My previous key to move in the snippet
        mode = "i",
        keymap = km.ctrl "p",
        action = M.jump_prev
    },
    { -- My previous key to move in the snippet
        mode = "i",
        keymap = km.ctrl "l",
        action = M.change_choice
    },
}
return M
