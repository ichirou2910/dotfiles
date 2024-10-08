return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", config = true },
            "williamboman/mason-lspconfig.nvim",
            "jay-babu/mason-nvim-dap.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        config = function()
            require("lsp")
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
            "gbprod/none-ls-shellcheck.nvim",
        },
    },
    {
        "yioneko/nvim-vtsls",
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
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
    {
        "rmagatti/goto-preview",
        event = "BufEnter",
        config = function()
            require("goto-preview").setup({
                height = 20,
            })
        end,
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = require("lackluster").color.gray3 })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "IlluminatedWordText" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "IlluminatedWordText" })
        end,
        init = function()
            vim.keymap.set("n", "<leader>ui", function()
                vim.cmd("IlluminateToggle")
            end, { silent = true, desc = "Toggle document highlight" })
        end,
    },
}
