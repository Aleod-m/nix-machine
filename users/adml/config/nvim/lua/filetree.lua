local plugins = require("utils.plugins")

plugins.add( {
    'kyazdani42/nvim-tree.lua',
    requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
    config = {
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
    }
})
