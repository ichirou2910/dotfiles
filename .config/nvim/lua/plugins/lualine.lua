local isEmpty = require("core.utils").isEmpty

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

local function session_status()
    local name = require("auto-session.lib").current_session_name()
    if not isEmpty(name) then
        return " "
    end
    return ""
end

local function cwd_name()
    local t = {}
    for str in string.gmatch(vim.fn.getcwd(), "([^" .. "/" .. "]+)") do
        table.insert(t, str)
    end
    return " " .. t[#t]
end

local function navic_location()
    return require("core.ui.winbar").get()
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
                        { navic_location },
                    },
                    lualine_x = {
                        -- {
                        --     noice.api.status.search.get,
                        --     cond = noice.api.status.search.has,
                        --     color = { fg = "ff9e64" },
                        -- },
                        -- {
                        --     noice.api.status.command.get,
                        --     cond = noice.api.status.command.has,
                        --     color = { fg = "ff9e64" },
                        -- },
                        { session_status },
                        "encoding",
                        "fileformat",
                        "filetype",
                    },
                },
                extensions = {
                    "fugitive",
                    "nvim-tree",
                    "symbols-outline",
                    "quickfix",
                    gitcommit,
                },
            })
        end,
    },
}
