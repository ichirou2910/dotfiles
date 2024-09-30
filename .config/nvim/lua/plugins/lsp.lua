return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp")
        end,
        dependencies = {
            "pmizio/typescript-tools.nvim",
        },
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
            "gbprod/none-ls-shellcheck.nvim",
        },
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require("goto-preview").setup({
                height = 20,
            })
        end,
        dependencies = { "neovim/nvim-lspconfig" },
    },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            require("lsp.rust")
        end,
        dependencies = { "neovim/nvim-lspconfig" },
    },
    {
        "seblj/roslyn.nvim",
        ft = "cs",
    },
    {
        "akinsho/flutter-tools.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim", -- optional for vim.ui.select
        },
    },
}
