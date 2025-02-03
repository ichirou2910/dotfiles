return {
    {
        "luukvbaal/statuscol.nvim",
        enabled = false,
        config = function()
            local builtin = require("statuscol.builtin")
            local cfg = {
                -- Builtin 'statuscolumn' options
                setopt = true, -- whether to set the 'statuscolumn', providing builtin click actions
                ft_ignore = {
                    "nvim-tree",
                    "spectre_panel",
                    "toggleterm",
                    "dapui_scopes",
                    "dapui_breakpoints",
                    "dapui_stacks",
                    "dapui_watches",
                    "dapui_console",
                    "dapui_repl",
                    "fugitive",
                },
                -- Default segments (fold -> sign -> line number + separator)
                segments = {
                    {
                        text = { builtin.lnumfunc, " " },
                        condition = { builtin.not_empty, true },
                        click = "v:lua.ScLa",
                    },
                    { text = { "%s" }, click = "v:lua.ScSa" },
                    {
                        text = { " ", builtin.foldfunc, " " },
                        click = "v:lua.ScFa",
                        condition = { true, builtin.not_empty, true },
                    },
                },
            }

            require("statuscol").setup(cfg)

            vim.api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
                callback = function(ev)
                    if vim.tbl_contains(cfg.ft_ignore, vim.bo.filetype) then
                        vim.cmd("setlocal statuscolumn=")
                        vim.cmd("set nu&")
                        vim.cmd("set rnu&")
                    end
                end,
            })
        end,
    },
}
