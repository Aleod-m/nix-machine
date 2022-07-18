local opts = { noremap = true, silent = true }

local keymap = vim.keymap.set

local M = {}

function M.set(mode, key, action, options)
    options = options or opts
    if options == nil then
        M.keymaps[#M.keymaps + 1] = {mode, key, action}
    else
        M.keymaps[#M.keymaps + 1] = {mode, key, action, options}
        options =  options
    end
    keymap(mode, key, action, options)
end

function M.set_keymaps(keymaps)
    for _, map in ipairs(keymaps) do
        M.set(map.mode, map.keymap, map.action, map.opt)
    end
end

M.leader = " "
M.localleader = ","

-- Modes added
require("keymaps.splits")
require("keymaps.move")


M.keymaps = {
    -- Disable space because its my leader
    { mode="", keymap="<Space>", action="<Nop>"},

    -- H/L to jump to the start/end of a line
    { mode="n", keymap="H", action="^" },
    { mode="v", keymap="H", action="^" },
    { mode="n", keymap="L", action="$" },
    { mode="v", keymap="L", action="$" },

    -- dH/dL to delete to the start/end of a line
    { mode="n", keymap="dH", action="d^" },
    { mode="v", keymap="dH", action="d^" },
    { mode="n", keymap="dL", action="d$" },
    { mode="v", keymap="dL", action="d$" },


    -- Remaps for my keyboard layout (workman-p)
    -- also move cursor in the column
    { mode="n", keymap="t", action="gk" },
    { mode="v", keymap="t", action="gk" },
    { mode="n", keymap="k", action="gj" },
    { mode="v", keymap="k", action="gj" },

    -- Source config.
    {
        mode="n",
        keymap="<leader>o",
        action=":lua package.loaded.init = nil<CR> :luafile ~/.config/nvim/init.lua<CR>",
        opt={ noremap = true },
    },

    -- Buffer operations
    {
        mode="n",
        keymap="<leader><leader>",
        action= function()
            local lastfile = vim.api.nvim_call_function("getreg", {"#", 1})
            if lastfile == "" then return end
            P("buffer " .. lastfile)
            vim.api.nvim_command("buffer " .. lastfile)
        end
    },

    { mode="n", keymap="<leader>w", action=":w<CR>" },

    -- Nice feature to have for blocks languages
    { mode="i", keymap="{<CR>", action="{<CR>}<ESC>O" },
    { mode="i", keymap="[<CR>", action="[<CR>]<ESC>O" },
    { mode="i", keymap="(<CR>", action="(<CR>)<ESC>O" },

    -- Moving lines of text
    -- Insert mode with the ctrl key
    { mode="i", keymap="<C-k>", action="<ESC>:m .+1<CR>==" },
    { mode="i", keymap="<C-t>", action="<ESC>:m .-2<CR>==" },
    -- Normal mode with the ctrl key
    { mode="n", keymap="<C-k>", action=":m .+1<CR>==" },
    { mode="n", keymap="<C-t>", action=":m .-2<CR>==" },
    -- In visual mode with ctrl key
    --{ mode="v", keymap="<C-t>", action="'<-2<CR>gv=gv" },
    { mode="v", keymap="<C-k>", action=":m'>+<CR>gv=gv" },
    { mode="v", keymap="<C-t>", action=":m-2<CR>gv=gv" },



    -- Clipboard integration
    { mode="n", keymap="<leader>y", action="\"+y" },
    { mode="v", keymap="<leader>y", action="\"+y" },
    { mode="n", keymap="<leader>p", action="\"+p" },
    { mode="n", keymap="<leader>P", action="\"+P" },

    -- Diagnostic
    {mode="n", keymap="<leader>dn", action=vim.diagnostic.goto_next},
    {mode="n", keymap="<leader>dp", action=vim.diagnostic.goto_prev},
}

vim.g.mapleader = " "
vim.g.maplocalleader = ","
for _, map in ipairs(M.keymaps) do
    local options = map.opt or opts
    keymap(map.mode, map.keymap, map.action, options)
end

return M
