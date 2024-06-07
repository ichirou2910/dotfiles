return {
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        config = function()
            require("trouble").setup({
                auto_preview = true,
                auto_jump = { "lsp_definitions", "lsp_implementations" },
                include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" },
                action_keys = {
                    jump_close = { "<cr>" },
                    jump = { "o", "<2-leftmouse>" },
                },
                signs = {
                    error = " ERR",
                    warning = " WRN",
                    hint = " HNT",
                    information = " INF",
                    other = "﫠OTH",
                },
            })
        end,
    },
}
