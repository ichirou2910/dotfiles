return {
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
                        DapUIPlayPauseNC = { bg = nil },
                        DapUIRestartNC = { bg = nil },
                        DapUIStopNC = { bg = nil },
                        DapUIUnavailableNC = { bg = nil },
                        DapUIStepIntoNC = { bg = nil },
                        DapUIStepBackNC = { bg = nil },
                        DapUIStepOutNC = { bg = nil },
                    },
                },
            })
            vim.cmd("colorscheme cyberdream")
        end,
    },
}
