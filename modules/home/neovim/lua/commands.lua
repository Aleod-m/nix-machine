
-- Permits to view dotfiles
function ViewDot() 
    local file = vim.cmd("echo expand('%:p')")
    
end
vim.api.nvim_create_user_command(
    'DotViz',
    
