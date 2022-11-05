vim.g.sonokai_style = "andromeda"
vim.g.sonokai_better_performance = 1
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_disable_italic_comment = 1
vim.g.sonokai_transparent_background = 1
vim.cmd [[colorscheme sonokai]]

local configuration = vim.fn['sonokai#get_configuration']()
local colors = vim.fn['sonokai#get_palette'](configuration.style, configuration.colors_override)

local lualinetheme = {
    normal = {
        a = {fg = colors.black[1],  bg = colors.green[1]},
        b = {fg = colors.black[1], bg = colors.blue[1]},
        c = {fg = colors.fg[1], bg = colors.bg1[1]}
    },
    insert = {a = {fg = colors.black[1], bg = colors.green[1]}},
    visual = {a = {fg = colors.black[1], bg = colors.yellow[1]}},
    replace = {a = {fg = colors.black[1], bg = colors.red[1]}},
    inactive = {
        a = {fg = colors.purple[1], bg = colors.black[1]},
        b = {fg = colors.fg[1], bg = colors.purple[1]},
        c = {fg = colors.grey[1], bg = colors.black[1]}
    }
}

require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = lualinetheme,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {{'filename', file_status=true, path=1, symbols={modified=" ", readonly=" ", unnamed="NONAME"}}},
        lualine_x = {'encoding'},
        lualine_y = {{'filetype', colored=false}},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

require('tabline').setup({
    no_name = '[No Name]',    -- Name for buffers with no name
    modified_icon = '',      -- Icon for showing modified buffer
    close_icon = '',         -- Icon for closing tab with mouse
    separator = "▌",          -- Separator icon on the left side
    padding = 3,              -- Prefix and suffix space
    color_all_icons = false,  -- Color devicons in active and inactive tabs
    right_separator = false,  -- Show right separator on the last tab
    show_index = false,       -- Shows the index of tab before filename
    show_icon = true,         -- Shows the devicon
})

local db = require('dashboard')
--╭─┬╮
--│ ││
--├─┼┤
--╰─┴╯
db.default_banner = {
    '',
    '   ╭────┬╮ ╭────╮ ╭────╮ ╭─╮╭─╮ ╭────╮ ╭───────╮',
    '   │ ╭╮ ││ │ ╭──╯ │╭──╮│ │ ││ │ ╰─╮╭─╯ │ ╭╮ ╭╮ │',
    '   │ ││ ││ │ ╰╮   ││  ││ │ ││ │   ││   │ ││ ││ │',
    '   │ ││ ││ │ ╭╯   ││  ││ │ ││ │   ││   │ ││ ││ │',
    '   │ ││ ││ │ ╰──╮ │╰──╯│ ╰╮╰╯╭╯ ╭─╯╰─╮ │ ││ ││ │',
    '   ╰─╯╰──╯ ╰────╯ ╰────╯  ╰──╯  ╰────╯ ╰─╯╰─╯╰─╯',
    '',
    ' [ TIP: To exit Neovim, just power off your computer. ] ',
}

db.custom_footer = { 
    '',
    '🎉 If I\'m not using Neovim, then my Neovim config must be broken!'
}

db.session_directory = "/home/adml/.config/nvim/session"
