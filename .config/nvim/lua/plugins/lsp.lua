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
        "mfussenegger/nvim-lint",
        opts = {
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                bash = { "shellcheck" },
                typescriptreact = { "eslint_d" },
            },
            linters = {},
        },
        config = function(_, opts)
            require("lsp.nvim-lint").setup(opts)
        end,
    },
    {
        "yioneko/nvim-vtsls",
    },
    {
        "GustavEikaas/easy-dotnet.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "folke/snacks.nvim",
        },
    },
    {
        "seblyng/roslyn.nvim",
        ft = "cs",
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
