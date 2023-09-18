return {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = { 
        'nvim-lua/plenary.nvim',
        "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
        "<leader>ff",
        "<leader>gs",
        "<leader>gf",
        "<leader>gb",
        "<leader>fb",
        "<leader>dl",
    },
    config = function() 
        local km = require("core.keymaps")
        local builtin = require("telescope.builtin")
        local tele = require("telescope")
        local leader = km.leader
        tele.setup({
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
        tele.load_extension("ui-select")
        km.set_keymaps({
            {mode= "n", keymap= leader "ff", action= builtin.find_files},
            {mode= "n", keymap= leader "gs", action= builtin.live_grep},
            {mode= "n", keymap= leader "gf", action= builtin.git_files},
            {mode= "n", keymap= leader "gb", action= builtin.git_branches},
            {mode= "n", keymap= leader "fb", action= builtin.buffers},
            {mode= "n", keymap= leader "dl", action= builtin.diagnostics},
        })
    end,
}
