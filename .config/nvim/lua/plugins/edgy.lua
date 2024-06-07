-- Config for edgy.nvim

local function is_float(win)
    return vim.api.nvim_win_get_config(win).zindex ~= nil
end

return {
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        init = function()
            vim.opt.laststatus = 3
            vim.opt.splitkeep = "screen"
        end,
        opts = {
            options = {
                top = { size = 0.3 },
                left = { size = 55 },
                bottom = { size = 0.3 },
            },
            top = {
                {
                    title = " GIT COMMIT",
                    ft = "gitcommit",
                },
            },
            left = {
                {
                    title = " GIT",
                    ft = "fugitive",
                    open = "Git",
                },
                {
                    title = " NOTES",
                    ft = "notes",
                    open = "Note",
                },
                {
                    title = " DEBUG SCOPE",
                    ft = "dapui_scopes",
                    size = { height = 0.4 },
                    open = "lua require'dapui'.open()",
                },
                {
                    title = " DEBUG BREAKPOINTS",
                    ft = "dapui_breakpoints",
                    size = { height = 0.2 },
                    open = "lua require'dapui'.open()",
                },
                {
                    title = " DEBUG STACKS",
                    ft = "dapui_stacks",
                    size = { height = 0.2 },
                    open = "lua require'dapui'.open()",
                },
                {
                    title = " DEBUG WATCHES",
                    ft = "dapui_watches",
                    size = { height = 0.2 },
                    open = "lua require'dapui'.open()",
                },
                {
                    title = " SEARCH & REPLACE",
                    ft = "spectre_panel",
                    wo = {
                        number = false,
                        relativenumber = false,
                    },
                },
            },
            bottom = {
                {
                    title = " TERMINAL",
                    ft = "toggleterm",
                    -- exclude floating windows
                    filter = function(_, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
                { title = "󰁨 TROUBLE", ft = "Trouble" },
                { title = " QUICKFIX", ft = "qf" },
                {
                    title = "󰋖 NEOVIM HELP",
                    ft = "help",
                    -- only show help buffers
                    filter = function(buf)
                        return vim.bo[buf].buftype == "help"
                    end,
                },
                {
                    title = " DEBUG REPL",
                    ft = "dap-repl",
                    wo = { winbar = false, statuscolumn = "" },
                    open = "lua require'dapui'.open()",
                },
                {
                    title = "References",
                    ft = "Trouble",
                    filter = function(buf, win)
                        return vim.b[buf].trouble_mode == "lsp_references" and not is_float(win)
                    end,
                    open = function()
                        require("trouble").open("lsp_references")
                    end,
                },
                {
                    title = "Definitions",
                    ft = "Trouble",
                    filter = function(buf, win)
                        return vim.b[buf].trouble_mode == "lsp_definitions" and not is_float(win)
                    end,
                    open = function()
                        require("trouble").open("lsp_definitions")
                    end,
                },
                {
                    title = "Type Definitions",
                    ft = "Trouble",
                    filter = function(buf, win)
                        return vim.b[buf].trouble_mode == "lsp_type_definitions" and not is_float(win)
                    end,
                    open = function()
                        require("trouble").open("lsp_type_definitions")
                    end,
                },
                {
                    title = " REST RESULT",
                    ft = "httpResult",
                },
            },

            animate = {
                enabled = false,
            },
            exit_when_last = false,
        },
    },
}
