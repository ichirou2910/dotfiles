-- Treesitter
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        init = function(plugin)
            require("lazy.core.loader").add_to_rtp(plugin)
            require("nvim-treesitter.query_predicates")
        end,
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                indent = {
                    enable = true,
                },
                patterns = {
                    default = {
                        "for",
                        "while",
                        "if",
                        "switch",
                        "case",
                    },
                    typescriptreact = {
                        "jsx_element",
                    },
                },
            })

            vim.treesitter.language.register("c_sharp", "cs")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        lazy = false,
        keys = {
            {
                "gs",
                function()
                    require("treesitter-context").go_to_context(vim.v.count1)
                end,
                desc = "Go to sticky scroll",
            },
            {
                "<leader>uc",
                "<cmd>TSContextToggle<CR>",
                desc = "Toggle context",
            },
        },
    },
}
