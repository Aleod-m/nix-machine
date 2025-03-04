local group = vim.api.nvim_create_augroup('AleodConfig', {clear = true})

-- Open Help in a vertical split on the right side.
vim.api.nvim_create_autocmd({"WinNew", "BufEnter"}, {
  group = group,
  once = true,
  callback = function ()
    -- Check if this is a help buffer.
    if not (vim.bo.bufftype == 'help' or vim.bo.filetype == 'man') then
      return
    end

    local origin_win = vim.fn.win_getid(vim.fn.winnr('#'))

    local help_buf = vim.fn.bufnr()
    local bufhidden = vim.bo.bufhidden
    vim.bo.bufhidden = 'hide'
    local old_help_win = vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(origin_win)
    vim.api.nvim_win_close(old_help_win, false)

    vim.cmd.vsplit() -- Create new help vertical split window and make it active.
    vim.api.nvim_win_set_buf(vim.api.nvim_get_current_win(), help_buf )
    vim.bo.bufhidden = bufhidden
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

