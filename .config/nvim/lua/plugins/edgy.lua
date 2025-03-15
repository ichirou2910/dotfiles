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
                    ft = "snacks_terminal",
                    size = { height = 0.4 },
                    title = " %{b:snacks_terminal.id}: %{b:term_title}",
                    filter = function(_buf, win)
                        return vim.w[win].snacks_win
                            and vim.w[win].snacks_win.position == "bottom"
                            and vim.w[win].snacks_win.relative == "editor"
                            and not vim.w[win].trouble_preview
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
            },

            animate = {
                enabled = false,
            },
            exit_when_last = false,
        },
    },
}
