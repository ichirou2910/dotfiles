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
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                    g = function()
                        local from = { line = 1, col = 1 }
                        local to = {
                            line = vim.fn.line("$"),
                            col = math.max(vim.fn.getline("$"):len(), 1),
                        }
                        return { from = from, to = to }
                    end,
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                },
            }
        end,
        config = function(_, opts)
            require("mini.ai").setup(opts)
        end,
    },
}
