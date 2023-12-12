require("aleod.keymaps")
require("aleod.options")

local group = vim.api.nvim_create_augroup('AleodConfig', {clear = true})
-- Add autocmd to try reloading all buffers on CursorHold.
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
  group = group,
  command = "checktime",
})

-- Equalize the splits if terminal get resized. 
-- Usefull for hyprland users when switching 
-- from nvim to another app in fullscreen.
vim.api.nvim_create_autocmd({"VimResized"}, {
  group = group,
  command = "wincmd ="
})
-- Expand all folds in vim enter.
vim.api.nvim_create_autocmd({"BufEnter"}, {
  group = group,
  command = "foldopen!"
})

-- Add the justfile file type. (XD)
vim.filetype.add({
  filename = { ["justfile"] = "justfile" }
})
