return {
    {
        "windwp/nvim-spectre",
        config = function()
            require("spectre").setup({
                color_devicons = true,
                live_update = true, -- auto excute search again when you write any file in vim
                highlight = { ui = "String", search = "DiffChange", replace = "DiffDelete" },
                is_block_ui_break = true,
            })
        end,
    },
}
