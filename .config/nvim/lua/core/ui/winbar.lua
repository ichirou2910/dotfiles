local M = {}

M.winbar_filetype_exclude = {
    "help",
    "dbui",
    "packer",
    "fugitive",
    "NvimTree",
    "Trouble",
    "spectre_panel",
    "toggleterm",
    "",
}

M.get = function()
    local status_ok, navic = pcall(require, "nvim-navic")
    if not status_ok then
        return
    end

    local navic_data = navic.get_location()

    if navic.is_available() then
        return navic_data
    else
        if not vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
            return ""
        end
        return navic_data
    end
end

_G.navic_location = function()
    return require("core.ui.winbar").get()
end
--[[ vim.o.winbar = "%{%v:lua.navic_location()%}" ]]

return M
