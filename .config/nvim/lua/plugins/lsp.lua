return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp")
        end,
        dependencies = {
            "Decodetalkers/csharpls-extended-lsp.nvim",
            "pmizio/typescript-tools.nvim",
        },
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
            "gbprod/none-ls-shellcheck.nvim",
        }
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
        "jmederosalvarado/roslyn.nvim",
        dependencies = { "neovim/nvim-lspconfig" },
    },
    {
        "akinsho/flutter-tools.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim", -- optional for vim.ui.select
        },
        -- config = true,
        -- config = function()
        --     require("lsp.flutter")
        -- end,
    },
}
