# The helpers module

A few modules that wrap neovim apis to make them more conveignant to use:
- `keymap` offers to set keymaps with a big table with `{noremap = true, slient
= true}` set by default. Also provides fucntions that makes the neovim
modifiers more readable.
- `log`: a log helper for the config using the vim.notify setting the level
based on the name of the function.
- `option` a helper to set options in bulk in a table.
- `plugin` wraps `vim.pack.add` to add url prefixes eg `gh:User/Repo ->
https://github.com/User/Repo`
- `cmd` provides a way to try commands and a function for creating the string
for keymaps.
- `autocmds` provide a module that returns a function that create a group based
on the string passed as an argument.
