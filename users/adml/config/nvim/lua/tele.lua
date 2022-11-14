-- Imports
local km = require'utils.keymaps'
local status, telescope = pcall(require, "telescope")

if not status then
    return false
end

local builtin = require("telescope.builtin")
-- find files using telescope
    --  by name
km.set("n", "<leader>ff", builtin.find_files)
    --  by content
km.set("n", "<leader>fg", builtin.live_grep)
-- git pickers
    -- files
km.set("n", "<leader>gf", builtin.git_files)
    -- branches
km.set("n", "<leader>gb", builtin.git_branches)

-- buffers
    -- switch
km.set("n", "<leader>fb", builtin.buffers)

-- search in project
km.set("n", "<leader>gs", builtin.live_grep)

-- Diagnostics
km.set("n", "<leader>dl", builtin.diagnostics)

telescope.setup{
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown { }
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
