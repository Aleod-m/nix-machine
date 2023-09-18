return {
    'hrsh7th/nvim-cmp',
    event = "InsertEnter",
    dependencies = {
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
        'saadparwaiz1/cmp_luasnip',
    },
    event = {"InsertEnter", "CmdlineEnter"},
    config = function()
        local cmp = require'cmp'
        cmp.setup
            { snippet = 
                { expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end
                }
            , mapping = cmp.mapping.preset.insert 
                { ["<C-n>"] = cmp.mapping.select_prev_item()
                , ["<C-p>"] = cmp.mapping.select_next_item()
                , ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" })
                , ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" })
                , ["<C-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" })
                , ["<C-e>"] = cmp.mapping 
                    { i = cmp.mapping.abort()
                    , c = cmp.mapping.close()
                    }
                -- Accept currently selected item. If none selected, `select` first item.
                -- Set `select` to `false` to only confirm explicitly selected items.
                , ["<CR>"] = cmp.mapping.confirm { select = true }
                }
            , sources = cmp.config.sources(
                { { name = 'nvim_lsp' }
                -- For luasnip users.
                , { name = 'luasnip' }
                }, { { name = 'buffer' } })
            , formatting =
                { fields = { "kind", "abbr", "menu" } }
            , view = { entries = { name = 'custom', selection_order = 'near_cursor' } }
            }

        cmp.setup.cmdline(':', 
            { mapping = cmp.mapping.preset.cmdline()
            , sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
            }
        )

        cmp.setup.cmdline({'/', '?'}, 
            { mapping = cmp.mapping.preset.cmdline()
            , sources = { { name = 'buffer' } }
            }
        )
    end
}
