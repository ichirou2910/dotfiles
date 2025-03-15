local noice = require("noice")

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
                    },
                    lualine_x = {
                        {
                            noice.api.status.search.get,
                            cond = noice.api.status.search.has,
                        },
                        {
                            noice.api.status.command.get,
                            cond = noice.api.status.command.has,
                        },
                        "location",
                    },
                    lualine_z = {
                        "filetype",
                    },
                },
            })
        end,
    },
}
