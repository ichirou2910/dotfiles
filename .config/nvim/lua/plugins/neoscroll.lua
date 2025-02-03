return {
    {
        "karb94/neoscroll.nvim",
        enabled = false,
        config = function()
            require("neoscroll").setup({
                easing_function = "sine",
                re_hook = function()
                    vim.opt.eventignore:append({
                        "WinScrolled",
                        "CursorMoved",
                    })
                end,
                post_hook = function()
                    vim.opt.eventignore:remove({
                        "WinScrolled",
                        "CursorMoved",
                    })
                end,
            })
        end,
        keys = {
            -- stylua: ingore
            { "<C-d>", mode = { "n", "x" }, desc = "Scroll half page down" },
            { "<C-u>", mode = { "n", "x" }, desc = "Scroll half page up" },
            { "zt", desc = "Top this line" },
            { "zz", desc = "Center this line" },
            { "zb", desc = "Bottom this line" },
        },
    },
}
