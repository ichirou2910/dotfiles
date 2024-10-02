return {
    {
        "folke/neodev.nvim",
        config = function()
            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")

            require("neodev").setup({
                library = {
                    runtime = runtime_path,
                    plugins = { "nvim-dap-ui" },
                    types = true,
                },
            })
        end,
    },

    -- Icons
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
        config = function()
            require("nvim-web-devicons").setup({ default = true })
        end,
    },

    -- Working dir
    {
        "notjedi/nvim-rooter.lua",
        config = function()
            require("nvim-rooter").setup()
        end,
    },

    -- Repeat stuff
    "tpope/vim-repeat",

    "tpope/vim-eunuch",
    "tpope/vim-sleuth",
    { "tpope/vim-fugitive", cmd = { "G", "Git" } },

    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        cmd = "MarkdownPreview",
        ft = "markdown",
        config = function()
            vim.cmd([[ source ~/.config/nvim/configs/markdown-preview.vim ]])
        end,
    },
}
