local autocmd = require("core.autocmd")()

autocmd("BufEnter", {
  callback = function(event)
    if vim.bo[event.buf].filetype ~= "help" then return end
    vim.cmd.wincmd('L')
    vim.cmd({cmd = 'wincmd',  args={'|'}, count=80})
  end
})

-- Add autocmd to try reloading all buffers on CursorHold.
autocmd({"CursorHold", "CursorHoldI"}, {
  command = "checktime",
})

-- Equalize the splits if terminal get resized. 
autocmd("VimResized", {
  command = "wincmd ="
})
