return {
    -- { "folke/tokyonight.nvim" },
    {
        "scottmckendry/cyberdream.nvim",
        config = function()
            require("cyberdream").setup({
                transparent = true,
                italic_comments = false,
                hide_fillchars = true,
                borderless_telescope = false,
                terminal_colors = true,
                theme = {
                    highlights = {
                        InclineNormal = { bg = "#3c4048" },
                    },
                },
            })
            vim.cmd("colorscheme cyberdream")
        end,
    },
}
