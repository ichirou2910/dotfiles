return {
    {
        "slugbyte/lackluster.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            local lackluster = require("lackluster")

            -- !must called setup() before setting the colorscheme!
            lackluster.setup({
                tweak_color = {
                    green = "#48c898",
                    lack = "#6f88d2",
                },
                tweak_highlight = {
                    InclineNormal = { bg = "#3c4048" },
                    -- StatusLine = { link = "Normal" },
                    -- StatusLineNC = { link = "NormalNC" },
                    -- DapUIPlayPauseNC = { bg = nil },
                    -- DapUIRestartNC = { bg = nil },
                    -- DapUIStopNC = { bg = nil },
                    -- DapUIUnavailableNC = { bg = nil },
                    -- DapUIStepIntoNC = { bg = nil },
                    -- DapUIStepBackNC = { bg = nil },
                    -- DapUIStepOutNC = { bg = nil },
                },
                tweak_background = {
                    normal = "none",
                    telescope = "none",
                    menu = lackluster.color.gray3,
                    popup = "default",
                },
                tweak_ui = {
                    disable_undercurl = false, -- set to true if you want underline instead of undercurl
                },
            })
        end,
        init = function()
            vim.cmd("colorscheme lackluster-mint")
        end,
    },
}
