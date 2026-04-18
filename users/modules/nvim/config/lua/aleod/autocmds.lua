local autocmd = require("h.autocmd")()
local cmd = require'h.cmd'

autocmd("BufEnter", {
  callback = function(event)
    if vim.bo[event.buf].filetype ~= "help" then return end
    cmd.win('L')
    cmd({cmd = 'wincmd',  args={'|'}, count=80})
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
