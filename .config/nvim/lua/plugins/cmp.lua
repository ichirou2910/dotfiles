return {
    {
        "saghen/blink.cmp",
        version = "*",
        opts = {
            keymap = {
                preset = "super-tab",
            },
            completion = {
                list = {
                    selection = {
                        preselect = function(ctx)
                            return not require("blink.cmp").snippet_active({ direction = 1 })
                        end,
                    },
                },
            },
            signature = {
                enabled = true,
            },
            appearance = {
                use_nvim_cmp_as_default = true,
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },
            snippets = {
                preset = "luasnip",
            },
        },
    },
}
