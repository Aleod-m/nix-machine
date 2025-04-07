-- Module for Keymaps utilities.
local opts = { noremap = true, silent = true }

local M = {}
M.keymaps = {}
M.leaderkey = vim.g.mapleader
M.localleaderkey = vim.g.maploclalleader


M.remove = vim.keymap.del
function M.remove_keymaps(keymaps)
    for _, map in ipairs(keymaps) do
        M.remove(map.mode, map.keymap, map.opt)
    end
end

function M.set(mode, key, action, options)
    options = vim.tbl_extend('force', opts, options or {})
    vim.keymap.set(mode, key, action, options)
end

function M.set_keymaps(keymaps)
    for _, map in ipairs(keymaps) do
        M.set(map.mode, map.keymap, map.action, map.opt)
    end
end

function M.mapleader(key)
    M.leaderkey = key
    vim.g.mapleader = key
end

function M.maplleader(key)
    M.localleaderkey = key
    vim.g.maploclalleader = key
end

function M.leader(keys)
    return "<Leader>" .. keys
end

function M.ctrl(key)
    return "<C-" .. key .. ">"
end

function M.alt(key)
    return "<A-" .. key .. ">"
end

return M
