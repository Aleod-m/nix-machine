local ss = require('smart-splits')
local cmd = require('utils.cmd')
local Hydra = require('hydra')

Hydra({
     name = "Splits",
     mode = "n", 
     body = "<Space>s",
     config = {
         timeout = false,
         invoke_on_body = true,
         hint = {
             border = 'rounded',
             position = 'middle'
         }
     },
     hint = [[
                    
 ^^^^^^     Move     ^^^^^^   ^^    Size   ^^   ^^     Split      ^^ ^^         Tabs          ^^
 ^^^^^^--------------^^^^^^   ^^-----------^^   ^^----------------^^ ^^-----------------------^^
 ^ ^ _t_ ^ ^   ^ ^ _T_ ^ ^    ^   _<C-t>_   ^   ^_s_: horizontally ^ ^_n_: next      _Q_: close^ 
 _h_ ^ ^ _l_   _H_ ^ ^ _L_    _<C-h>_ _<C-l>_   ^_v_: vertically   ^ ^_p_: previous  _O_: new  ^
 ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^    ^   _<C-k>_   ^   ^_q_: close        ^ ^_N_: Move to next        ^
 focus^^^^^^   window^^^^^^   ^ _=_ equalize^   ^_b_: choose buffer^ ^_P_: Move to previous    ^
]],
     heads = {
        -- Move arround Splits
        { "h"    , "<C-w>h"},
        { "t"    , "<C-w>k"},
        { "k"    , "<C-w>j"},
        { "l"    , "<C-w>l"},

        -- Move Splits arround
        { "H"    , cmd "WinShift left" },
        { "T"    , cmd "WinShift up" },
        { "K"    , cmd "WinShift down" },
        { "L"    , cmd "WinShift right" },

        -- Resize splits
        { '<C-h>', function() ss.resize_left(2)  end },
        { '<C-k>', function() ss.resize_down(2)  end },
        { '<C-t>', function() ss.resize_up(2)    end },
        { '<C-l>', function() ss.resize_right(2) end },
        { '='    , '<C-w>=', { desc = 'equalize'} },

        -- Create and close splits
        { 's'    , '<C-w>s' },
        { 'v'    , '<C-w>v' },
        { "q"    , cmd.try 'close' },
        { "b"    , require("telescope.builtin").buffers },

        -- Manage Tabs
        { 'n'    , cmd 'tabn'},
        { 'p'    , cmd 'tabp'},
        { 'N'    , cmd.try 'tabm +'},
        { 'P'    , cmd.try 'tabm -'},
        { 'Q'    , cmd.try 'tabc'},
        { 'O'    , cmd 'tabnew'},
        
    },
})
