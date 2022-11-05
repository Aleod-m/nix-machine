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
    --─ │ ├ ┼ ┤┌ └ ┘ ┐ ┬ ┴
    --╭ ╮ ╯ ╰
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
        { '<C-h>', function() ss.resize_left(2)  end },
        { '<C-k>', function() ss.resize_down(2)  end },
        { '<C-t>', function() ss.resize_up(2)    end },
        { '<C-l>', function() ss.resize_right(2) end },
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



require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
    disable_netrw = true,
    sort_by = "extension",
    view = {
        adaptive_size = true,
        mappings = {
            custom_only = true,
            list = {
                { key = "e", action = "edit" },
                { key = "o", action = "edit" },
                { key = "E", action = "edit_in_place" },
                { key = "s", action = "split" },
                { key = "v", action = "vsplit" },
                { key = "et", action = "tabnew" },

                { key = "T", action = "parent_node" },
                { key = "go", action = "cd" },
                { key = "c", action = "close_node" },

                -- cut copy and paste
                { key = "y", action = "copy" },
                { key = "p", action = "paste" },
                { key = "d", action = "cut" },
                { key = "r", action = "rename" },
                { key = "a", action = "create" },

                { key = "f", action = "live_filter" },
                { key = "q", action = "close" },
            },
        },
    },
} -- END_DEFAULT_OP
