return {
    "L3MON4D3/LuaSnip",
    config = function() 
        local km = require("core.keymaps")
        local ls = require("luasnip")
        function expand()
            if ls.expandable() then
                ls.expand()
            end
        end

        function jump_next()
            if ls.jumpable() then
                ls.jump()
            end
        end

        function jump_prev()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end

        function change_choice()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end

        km.set_keymaps {
            { -- My expand key
                mode = {"i", "s"},
                keymap = km.ctrl "e",
                action = expand
            },
            { -- My next key to move in the snippet
                mode = "i",
                keymap = km.ctrl "n",
                action = jump_next
            },
            { -- My previous key to move in the snippet
                mode = "i",
                keymap = km.ctrl "p",
                action = jump_prev
            },
            { -- My previous key to move in the snippet
                mode = "i",
                keymap = km.ctrl "l",
                action = change_choice
            },
        }
    end
}
