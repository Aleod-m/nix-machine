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
