return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp")
        end,
        dependencies = {
            "Decodetalkers/csharpls-extended-lsp.nvim",
            "jose-elias-alvarez/null-ls.nvim",
            { "jayp0521/mason-null-ls.nvim", commit = "ab5d99619de2263508abb7fb05ef3a0f24a8d73d" },
            "pmizio/typescript-tools.nvim",
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
