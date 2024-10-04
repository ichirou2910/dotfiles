return {
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
