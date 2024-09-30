local isEmpty = require("core.utils").isEmpty
local noice = require("noice")

-- Extensions
local gitcommit = {
    sections = {
        lualine_a = {
            function()
                local icon = "" -- e0a0
                return icon .. " " .. vim.fn.FugitiveHead()
            end,
        },
        lualine_b = {
            function()
                return [[Commit]]
            end,
        },
    },
    filetypes = { "gitcommit" },
}

local function cwd_name()
    local t = {}
    for str in string.gmatch(vim.fn.getcwd(), "([^" .. "/" .. "]+)") do
        table.insert(t, str)
    end
    return " " .. t[#t]
end

return {
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "cyberdream",
                    globalstatus = true,
                    component_separators = { left = " ", right = " " },
                    section_separators = { left = " ", right = " " },
                    ignore_focus = {
                        "NvimTree",
                        "packer",
                        "toggleterm",
                        "Trouble",
                    },
                },
                sections = {
                    lualine_a = { { cwd_name } },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = {
                        { "filename", path = 1 },
                        "%=",
                        {
                            require("tmux-status").tmux_session,
                            cond = require("tmux-status").show,
                        },
                        {
                            require("tmux-status").tmux_windows,
                            cond = require("tmux-status").show,
                        },
                    },
                    lualine_x = {
                        {
                            noice.api.status.search.get,
                            cond = noice.api.status.search.has,
                            color = { fg = "ff9e64" },
                        },
                        {
                            noice.api.status.command.get,
                            cond = noice.api.status.command.has,
                            color = { fg = "ff9e64" },
                        },
                        "location",
                    },
                    lualine_z = {
                        "filetype",
                    },
                },
                extensions = {
                    "fugitive",
                    "quickfix",
                    gitcommit,
                },
            })
        end,
    },
}
