-- Imports
local keymap = require'keymaps'
local status, telescope = pcall(require, "telescope")

if not status then
    return false
end

local builtin = require("telescope.builtin")
-- find files using telescope
    --  by name
keymap.set("n", "<leader>ff", builtin.find_files)
    --  by content
keymap.set("n", "<leader>fg", builtin.live_grep)
-- git pickers
    -- files
keymap.set("n", "<leader>gf", builtin.git_files)
    -- branches
keymap.set("n", "<leader>gb", builtin.git_branches)

-- buffers
    -- switch
keymap.set("n", "<leader>fb", builtin.buffers)
    -- search in current
--keymap.set("n", "<leader>s", builtin.current_buffer_fuzzy_find)

-- Diagnostics
keymap.set("n", "<leader>dl", builtin.diagnostics)

telescope.setup{
    extensions = {
        ["ui-select"] = {
            theme = "dropdown",
        }
    },
    pickers = {
        current_buffer_fuzzy_find = {
           sorting_strategy = "ascending",
            prompt_position = "top",
        }
    },
    defaults = {
        prompt_prefix = " ",
    }
}
telescope.load_extension("ui-select")
return true
