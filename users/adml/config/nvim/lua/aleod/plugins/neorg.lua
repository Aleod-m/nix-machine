return {}
--return {
--    "nvim-neorg/neorg",
--    run = ":Neorg sync-parsers", -- This is the important bit!
--    config = function()
--        require("neorg").setup {
--          load = {
--            ["core.defaults"] = {}, 
--            ["core.completion"] = { engine = "nvim-cmp"}, 
--            ["core.dirman"] = { config = {
--                workspaces = { notes = "~/notes/src" },
--                default_workspace = "notes",
--              } 
--            },
--            ["core.export"] = { config = { path = { notes = "~/notes/view" }, filetype = "markdown" } },
--          },
--        }
--    end,
--}