local plugins = require("utils.plugins")
local mode = require("utils.mode")

plugins.add({
    "folke/noice.nvim",
    deps = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
})

plugins.add({
    'nvim-lualine/lualine.nvim',
    lazy = false,
    config = {
        options = {
            icons_enabled = true,
            theme = require'konokai.themes'.lualine,
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
        },
        winbar = {
            lualine_a = { require('utils.mode').active },
            lualine_b = {{'filename', file_status=true, path=1, symbols={modified=" ", readonly=" ", unnamed="NONAME"}}, 'branch'},
            lualine_c = {'diff', 'diagnostics'},
            lualine_x = {'encoding', {'filetype', colored=true}},
            lualine_y = {},
            lualine_z = {'location'}
        },
        inactive_winbar = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
    }
})

plugins.add({
    'AdrienDML/konokai',
    lazy = false,
    dependencies = {
        'rktjmp/lush.nvim',
    },
    config = function() vim.cmd [[colorscheme konokai]] end,
})

plugins.add({
    'seblj/nvim-tabline',
    event = "TabNew",
    config = {
        no_name = '[No Name]',    -- Name for buffers with no name
        modified_icon = '',      -- Icon for showing modified buffer
        close_icon = '',         -- Icon for closing tab with mouse
        separator = "▌",          -- Separator icon on the left side
        padding = 3,              -- Prefix and suffix space
        color_all_icons = false,  -- Color devicons in active and inactive tabs
        right_separator = false,  -- Show right separator on the last tab
        show_index = false,       -- Shows the index of tab before filename
        show_icon = true,         -- Shows the devicon
    }
})

plugins.add({
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = {
        theme = 'Doom',
        config = {
            header = {
                '',
                '   ╭────┬╮ ╭────╮ ╭────╮ ╭─╮╭─╮ ╭────╮ ╭───────╮',
                '   │ ╭╮ ││ │ ╭──╯ │╭──╮│ │ ││ │ ╰─╮╭─╯ │ ╭╮ ╭╮ │',
                '   │ ││ ││ │ ╰╮   ││  ││ │ ││ │   ││   │ ││ ││ │',
                '   │ ││ ││ │ ╭╯   ││  ││ │ ╰╯ │   ││   │ ││ ││ │',
                '   │ ││ ││ │ ╰──╮ │╰──╯│ ╰╮  ╭╯ ╭─╯╰─╮ │ ││ ││ │',
                '   ╰─╯╰──╯ ╰────╯ ╰────╯  ╰──╯  ╰────╯ ╰─╯╰─╯╰─╯',
                '',
                ' [ TIP: To exit Neovim, just power off your computer. ] ',
            },
            center = {},
            footer = { 
                '',
                '🎉 If I\'m not using Neovim, then my Neovim config must be broken!'
            },
        }
    }
})
