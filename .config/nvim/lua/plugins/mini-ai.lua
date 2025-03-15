return {
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 1000,
                custom_textobjects = {
                    custom_textobjects = {
                        b = MiniExtra.gen_ai_spec.buffer(),
                        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                    },
                },
            }
        end,
        config = function(_, opts)
            require("mini.ai").setup(opts)
        end,
    },
}
