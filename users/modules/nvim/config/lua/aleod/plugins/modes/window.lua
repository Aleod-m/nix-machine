-- Todo setup kitty splits & integration with smart-splits.
return {
  dependencies = {
    'nvim-telescope/telescope.nvim',
    -- TODO: Reenable when smart-splits support 0.10
    'mrjones2014/smart-splits.nvim',
  },
  keys = { "<Space>s" },
  mode = function()
    local cmd = require('core.cmd')
    local ss = require("smart-splits")
    local ctrl = require('core.keymaps').ctrl
    return {
      name = "Test",
      mode = "n",
      body = "<Leader>s",
      config = {
        timeout = false,
        invoke_on_body = true,
      },
      heads = {
        -- Move arround Splits
        --{ '<Tab>', ctrl'w' .. 'w' },
        --{ 'k', ctrl'w' .. 'j' },
        --{ 't', ctrl'w' .. 'k' },
        --{ 'h', ctrl'w' .. 'h' },
        --{ 'l', ctrl'w' .. 'l' },
        --{ '<Space><Space>', ctrl'w' .. 'p' },
        { "h", ss.move_cursor_left},
        { "t", ss.move_cursor_up   },
        { "k", ss.move_cursor_down },
        { "l", ss.move_cursor_right},
        
        -- Move Splits arround
        --{ "H", ctrl'w' .. 'H' },
        --{ "T", ctrl'w' .. 'K' },
        --{ "K", ctrl'w' .. 'J' },
        --{ "L", ctrl'w' .. 'L' },
        --{ "L", ctrl'w' .. 'L' },
        --{ "C", ctrl'w' .. 'x' },
        { "H", function() ss.swap_buf_left({move_cursor = true }) end },
        { "T", function() ss.swap_buf_up({move_cursor = true })   end },
        { "K", function() ss.swap_buf_down({move_cursor = true }) end },
        { "L", function() ss.swap_buf_right({move_cursor = true}) end },
        
        -- Resize splits
        { '='    , ctrl'w' .. '=' },
        --{ '<C-h>', ctrl'w' .. '<' },
        --{ '<C-k>', ctrl'w' .. '+' },
        --{ '<C-t>', ctrl'w' .. '-' },
        --{ '<C-l>', ctrl'w' .. '>' },
        { '<C-h>', function() ss.resize_left(2)  end },
        { '<C-k>', function() ss.resize_down(2)  end },
        { '<C-t>', function() ss.resize_up(2)    end },
        { '<C-l>', function() ss.resize_right(2) end },
                --
        -- Create and close splits
        { 's', ctrl'w' .. 's'  },
        { 'v', ctrl'w' .. 'v'  },
        { "q", cmd.try 'close'     },
        { "x", cmd.try 'x'     },
        { "w", cmd.try 'w'     },

        -- Change current split.
        { "b", require'telescope.builtin'.buffers, {exit = true} },
        { "F", require'telescope.builtin'.find_files, {exit = true} },

        -- Manage Tabs
        { 'n', cmd 'tabn'       },
        { 'p', cmd 'tabp'       },
        { 'N', cmd.try 'tabm +' },
        { 'P', cmd.try 'tabm -' },
        { 'Q', cmd.try 'tabc'   },
        { 'O', cmd 'tabnew'     },

        { '<Esc>', nil, { exit = true, nowait = true, desc = 'exit' } }
      }
    }
  end,
}
