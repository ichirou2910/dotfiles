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
                highlight = {
                    -- enable = false, -- false will disable the whole extension
                    disable = function(lang, buf)
                        local max_filesize = 1000 * 1024 -- 1 MB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    use_languagetree = true,
                },
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
