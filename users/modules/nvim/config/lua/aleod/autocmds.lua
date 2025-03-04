local group = vim.api.nvim_create_augroup('AleodConfig', {clear = true})

vim.api.nvim_create_autocmd({"BufEnter"}, {
  group = group,
  callback = function(event)
    if vim.bo[event.buf].filetype ~= "help" then return end
    vim.cmd.wincmd('L')
  end
})
-- Add autocmd to try reloading all buffers on CursorHold.
vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
  group = group,
  command = "checktime",
})

-- Equalize the splits if terminal get resized. 
vim.api.nvim_create_autocmd({"VimResized"}, {
  group = group,
  command = "wincmd ="
})

