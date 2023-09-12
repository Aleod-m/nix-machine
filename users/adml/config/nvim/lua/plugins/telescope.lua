return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function() 
        local telescope = require("telescope")
        telescope.setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown { }
                },
            },
            pickers = {
                current_buffer_fuzzy_find = {
                    sorting_strategy = "ascending",
                    prompt_position = "top",
                },
            },
            defaults = {
                prompt_prefix = " ",
            },
        })
        local builtin = require("telescope.builtin")
        local km = require'utils.keymaps'
        local leader = km.leader
        -- find files using telescope
        --  by name
        km.set_keymaps({
            {mode = "n", keymap = leader "ff", action = builtin.find_files}
            {mode = "n", keymap = leader "gs", action = builtin.live_grep}
            {mode = "n", keymap = leader "gf", action = builtin.git_files}
            {mode = "n", keymap = leader "gb", action = builtin.git_branches}
            {mode = "n", keymap = leader "fb", action = builtin.buffers}
            {mode = "n", keymap = leader "dl", action = builtin.diagnostics}
        })
        telescope.load_extension("ui-select")
    end
}
