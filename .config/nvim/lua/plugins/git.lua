return {
    {
        "echasnovski/mini.diff",
        config = function()
            require("mini.diff").setup({
                view = {
                    signs = {
                        add = "│",
                        change = "│",
                        delete = "│",
                    },
                },
            })
        end,
    },
    { "tpope/vim-fugitive" },
}
