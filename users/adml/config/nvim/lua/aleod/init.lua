require("aleod.keymaps")
require("aleod.options")

local group = vim.api.nvim_create_augroup('AleodConfig', {clear = true})
-- Add autocmd to try reloading all buffers on CursorHold.
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
  group = group,
  command = "checktime",
})

vim.api.nvim_create_autocmd({"VimResized"}, {
  group = group,
  command = "wincmd ="
})

vim.api.nvim_create_autocmd({"FileType"}, {
  group = group,
  pattern = "nix",
  callback = function(args)
    vim.bo.ts = 2
    vim.bo.sw = 2
  end
})
