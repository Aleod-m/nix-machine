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
M.plugins = {}

function M.add(plugin) 
    M.plugins[#M.plugins + 1] = plugin
end

function M.finalize(opts)
    options = opts or M.default_opts
    require("lazy").setup(plugins, options)
end

M.default_opts = {}

return M

