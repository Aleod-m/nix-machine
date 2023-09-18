-- Module for Plugin utilities.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local M = {}

function M.load(paths)
    local paths = vim.tbl_map(function(v) return { import = v } end, paths)
    require("lazy").setup(paths, {
        checker = {
            enabled = true,
            notify = false,
        },
        change_detecction = {
            notify = false,
        },
    })
end

return M
