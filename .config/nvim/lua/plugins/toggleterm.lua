return {
    {
        "akinsho/toggleterm.nvim",
        cmd = { "ToggleTerm", "TermExec" },
        config = function()
            require("toggleterm").setup({
                persist_size = false,
                direction = "horizontal",
                float_opts = {
                    winblend = 0,
                },
                highlights = { NormalFloat = { link = "ToggletermFloat" } },
            })

            vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], { noremap = true })
        end,
    },
}
