local icons = require("core.icons")

return {
    {
        "SmiteshP/nvim-navic",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("nvim-navic").setup({
                separator = " " .. icons.ui.ChevronRight .. " ",
                highlight = true,
                depth_limit = 0,
                depth_limit_indicator = "..",
                safe_output = true,
            })
            vim.g.navic_silence = true
        end,
    },
}
