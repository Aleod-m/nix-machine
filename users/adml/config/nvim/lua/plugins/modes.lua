local cmd = require('utils.cmd')

local plugins = require('utils.plugins')
local Mode = require('utils.mode')

plugins.add('mrjones2014/smart-splits.nvim')


--─ │ ├ ┼ ┤┌ └ ┘ ┐ ┬ ┴
--╭ ╮ ╯ ╰
--- Window mode
Mode.add({
    name = "Window",
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
    Window, Splits, and Tabs management.
╭^^────────────^^┬^^───────────^^┬^──────────────────^┬^──────────────────^^╮
│^^ Move focus ^^│^^Move window^^│^      Split       ^│^      Window      ^^│
├^^────────────^^┼^^───────────^^┼^──────────────────^┤^──────────────────^^┤
│^      _t_     ^│^     _T_     ^│ _s_: horizontally  │ _f_: file explorer ^│
│    _h_   _l_   │   _H_   _L_   │ _v_: vertically    │ _F_: file finder   ^│
│^      _k_     ^│^     _K_     ^│ _q_: close         │ _b_: buffer finder ^│
├^^────────────^^┼^^───────────^^┴^──────────────────^┴^──────────────────^^┤
│^^   Resize   ^^│^^           ^^ ^       Tabs       ^ ^                  ^^│
├^^────────────^^┼^^───────────^^─^──────────────────^─^──────────────────^^┤
│^    _<C-t>_   ^│    _n_: next^^ ^tab               ^ ^_Q_: close tab      │
│ _<C-h>_ _<C-l>_│    _p_: prev^^i^ous tab           ^ ^_O_: new tab        │
│^    _<C-k>_   ^│    _N_: Mov^^e^ tab to next       ^ ^_R_: rename tab     │
│^ _=_ equalize ^│    _P_: Mov^^e^ tab to previous   ^ ^_C_: clear tab nave │
╰^^────────────^^┴^^───────────^^─^──────────────────^─^──────────────────^^╯]],
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
        { '<C-h>', function() require("smart-splits").resize_left(2)  end },
        { '<C-k>', function() require("smart-splits").resize_down(2)  end },
        { '<C-t>', function() require("smart-splits").resize_up(2)    end },
        { '<C-l>', function() require("smart-splits").resize_right(2) end },
        { '='    , '<C-w>=', { desc = 'equalize'} },

        -- Create and close splits
        { 's'    , '<C-w>s' },
        { 'v'    , '<C-w>v' },
        { "q"    , cmd.try 'close' },
        { "b"    , cmd "Telescop buffers"},
        { "F"    , cmd "Telescop find_files"},
        { "f"    , cmd "NvimTreeOpen" },

        -- Manage Tabs
        { 'n'    , cmd 'tabn'},
        { 'p'    , cmd 'tabp'},
        { 'N'    , cmd.try 'tabm +'},
        { 'P'    , cmd.try 'tabm -'},
        { 'Q'    , cmd.try 'tabc'},
        { 'O'    , cmd 'tabnew'},
        { 'R'    , require('tabline.actions').set_tabname},
        { 'C'    , require('tabline.actions').clear_tabname},

    },
})
