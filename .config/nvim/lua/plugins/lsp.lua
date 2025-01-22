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
            -- Event to trigger linters
            events = { "BufWritePost", "BufReadPost", "InsertLeave" },
            linters_by_ft = {
                bash = { "shellcheck" },
                typescriptreact = { "eslint_d" },
                -- Use the "*" filetype to run linters on all filetypes.
                -- ['*'] = { 'global linter' },
                -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
                -- ['_'] = { 'fallback linter' },
                -- ["*"] = { "typos" },
            },
            -- LazyVim extension to easily override linter options
            -- or add custom linters.
            ---@type table<string,table>
            linters = {
                -- -- Example of using selene only when a selene.toml file is present
                -- selene = {
                --   -- `condition` is another LazyVim extension that allows you to
                --   -- dynamically enable/disable linters based on the context.
                --   condition = function(ctx)
                --     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
                --   end,
                -- },
            },
        },
        config = function(_, opts)
            require("lsp.nvim-lint").setup(opts)
        end,
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
