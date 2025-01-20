return {
    {
        "OXY2DEV/markview.nvim",
        lazy = false,

        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },

        config = function()
            local presets = require("markview.presets")

            require("markview").setup({
                checkboxes = presets.checkboxes.nerd,
                headings = presets.headings.marker,
                horizontal_rules = presets.horizontal_rules.thin,

                hybrid_modes = nil,
            })
        end,

        keys = {
            { "<leader>mh", ft = "markdown", mode = "n", "<cmd>Markview hybridToggle<cr>", desc = "Toggle hybrid" },
            { "<leader>ms", ft = "markdown", mode = "n", "<cmd>Markview splitToggle<cr>", desc = "Toggle split" },
            { "<leader>mt", ft = "markdown", mode = "n", "<cmd>Markview toggle<cr>", desc = "Toggle" },
        },
    },
}
