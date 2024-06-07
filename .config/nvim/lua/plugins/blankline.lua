return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufWinEnter",
        config = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            local hooks = require("ibl.hooks")

            local highlight = {
                "TSRainbowRed",
                "TSRainbowOrange",
                "TSRainbowYellow",
                "TSRainbowGreen",
                "TSRainbowCyan",
                "TSRainbowViolet",
            }

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "TSRainbowRed", { fg = "#ed8796" })
                vim.api.nvim_set_hl(0, "TSRainbowOrange", { fg = "#f5a97f" })
                vim.api.nvim_set_hl(0, "TSRainbowYellow", { fg = "#eed49f" })
                vim.api.nvim_set_hl(0, "TSRainbowGreen", { fg = "#a6da95" })
                vim.api.nvim_set_hl(0, "TSRainbowCyan", { fg = "#7dc4e4" })
                vim.api.nvim_set_hl(0, "TSRainbowViolet", { fg = "#c6a0f6" })
            end)

            vim.g.rainbow_delimiters = {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = highlight,
            }

            require("ibl").setup({
                indent = {
                    char = "▏",
                },
                scope = {
                    char = "▏",
                    highlight = highlight,
                },
                exclude = {
                    filetypes = {
                        "vimwiki",
                        "diagnosticpopup",
                        "packer",
                        "markdown",
                        "WhichKey",
                    },
                },
            })

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
}
