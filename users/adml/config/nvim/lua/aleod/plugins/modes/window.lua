-- Todo setup kitty splits & integration with smart-splits.
return 
    { "mrjones2014/smart-splits.nvim"
    , dependencies = 
        { 'anuvyklack/hydra.nvim'
        , 'nvim-telescope/telescope.nvim'
        }
    , key = "<space>s"
    , config = function()
        local cmd = require('core.cmd')
        local ss = require("smart-splits")
        local ctrl = require'core.keymaps'.ctrl
        require'hydra'(
            { name = "Window"
            , mode = "n"
            , body = "<Space>s"
            , config = 
                { timeout = false
                , invoke_on_body = true
                }
            , heads = 
                -- Move arround Splits
                { { "h", ss.move_cursor_left}
                , { "t", ss.move_cursor_up   }
                , { "k", ss.move_cursor_down }
                , { "l", ss.move_cursor_right}
                -- Move Splits arround
                , { "H", function() ss.swap_buf_left({move_cursor = true}) end }
                , { "T", function() ss.swap_buf_up({move_cursor = true })   end }
                , { "K", function() ss.swap_buf_down({move_cursor = true }) end }
                , { "L", function() ss.swap_buf_right({move_cursor = true }) end }
                -- Resize splits
                , { '<C-h>', function() ss.resize_left(2)  end }
                , { '<C-k>', function() ss.resize_down(2)  end }
                , { '<C-t>', function() ss.resize_up(2)    end }
                , { '<C-l>', function() ss.resize_right(2) end }
                , { '='    , ctrl('w') .. '=', { desc = 'equalize'   } }
                -- Create and close splits
                , { 's', ctrl('w') .. 's'                      }
                , { 'v', ctrl('w') .. 'v'                      }
                , { "q", cmd.try 'close'                       }
                , { "b", require'telescope.builtin'.buffers    }
                , { "F", require'telescope.builtin'.find_files }
                -- Manage Tabs
                , { 'n', cmd 'tabn'                               }
                , { 'p', cmd 'tabp'                               }
                , { 'N', cmd.try 'tabm +'                         }
                , { 'P', cmd.try 'tabm -'                         }
                , { 'Q', cmd.try 'tabc'                           }
                , { 'O', cmd 'tabnew'                             }
                , { 'R', require('tabline.actions').set_tabname   }
                , { 'C', require('tabline.actions').clear_tabname }
                }
            }
        )
    end
    }
