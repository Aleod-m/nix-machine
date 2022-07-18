local ss = require('smart-splits')
local Hydra = require('hydra')
Hydra({
     name = "Move",
     mode = "n", 
     body = "<Space>z",
     config = {
         timeout = false,
         color = 'amaranth',
     },
     heads = {
        -- Move Up and Down 
        { "u"    , "<C-u>"},
        { "d"    , "<C-d>", {desc = "^/v"} },
        { "l"    , "zh"},
        { "r"    , "zl", {desc = "</>"}},

        -- Move More Quickly
        { "U"    , "<C-b>"},
        { "D"    , "<C-f>", {desc = "page ^/v"}},
        { "R"    , "zL"},
        { "L"    , "zR", {desc = "half screen </>"}},

        -- Move view around line
        { "t"    , "zt"},
        { "b"    , "zb", {desc = "around line ^/v"}},
        { "m"    , "zz", {desc = "middle"}},
        { "l"    , "zs"},
        { "r"    , "ze", {desc = "</>"}},
    },
})
