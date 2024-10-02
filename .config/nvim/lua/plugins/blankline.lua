return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufWinEnter",
        config = function()
            require("ibl").setup({
                indent = {
                    char = "▏",
                },
                scope = {
                    char = "▏",
                },
                exclude = {
                    filetypes = {
                        "vimwiki",
                        "diagnosticpopup",
                        "packer",
                        "markdown",
                        "WhichKey",
                    },
                },
            })
        end,
    },
}
