return 
    { 'anuvyklack/hydra.nvim' 
    , name = "Git mode"
    , dependencies = 
        { 'TimUntersberger/neogit'
        , 'lewis6991/gitsigns.nvim'
        }
    , keys = "<Space>g"
    , config = function()
        local gitsigns = require'gitsigns'
        require'hydra'
            { name = "Git"
            , mode = 'n'
            , body = '<leader>g'
            , config = 
                { buffer = bufnr
                , color = "amaranth"
                , invoke_on_body = true
                , timeout = false
                , on_enter = function()
                    vim.cmd 'mkview'
                    vim.cmd 'silent! %foldopen!'
                    vim.bo.modifiable = false
                end
                , on_exit = function()
                    local cursor_pos = vim.api.nvim_win_get_cursor(0)
                    vim.cmd 'loadview'
                    vim.api.nvim_win_set_cursor(0, cursor_pos)
                    vim.cmd 'normal zv'
                end
                , 
                }
            , heads =
                { { 'n', gitsigns.next_hunk, { desc = 'next hunk' } }
                , { 'p', gitsigns.prev_hunk, { desc = 'prev hunk' } }
                , { 's', gitsigns.stage_hunk, { desc = 'stage hunk' } }
                , { 'u', gitsigns.undo_stage_hunk, { desc = 'undo last stage' } }
                , { 'S', gitsigns.stage_buffer, { desc = 'stage buffer' } }
                , { 'r', gitsigns.revert_hunk, { desc = 'revert hunk' } }
                , { 'd', gitsigns.toggle_deleted, { desc = 'toggle deleted' } }
                , { 'b', gitsigns.blame_line, { desc = 'blame' } }
                , { 'B', function() gitsigns.blame_line{ full = true } end, { desc = 'blame show full' } }
                , { '/', gitsigns.show, { exit = true, desc = 'show base file' } } -- show the base of the file
                , { '<Enter>', '<Cmd>Neogit<CR>', { exit = true, desc = 'Neogit' } }
                , { 'q', nil, { exit = true, nowait = true, desc = 'exit' } }
                }
            }
    end
    }
