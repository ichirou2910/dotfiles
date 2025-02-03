return {
    {
        "nvim-neotest/neotest",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("neotest").setup({
                adapters = {},
            })
        end,
    },
}
