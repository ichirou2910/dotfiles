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
}
