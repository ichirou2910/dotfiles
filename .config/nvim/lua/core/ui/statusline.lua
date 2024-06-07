local fn = vim.fn
local api = vim.api

local M = {}

vim.cmd([[highlight StatusLine guibg=None guifg=#e7e7e7 gui=nocombine]])
vim.cmd([[highlight StatusTitleL guibg=#116cac guifg=#e7e7e7 gui=nocombine]])
vim.cmd([[highlight StatusTitleR guibg=#65b05d guifg=#1c1c2a gui=nocombine]])
vim.cmd([[highlight StatusSep guibg=None guifg=#34383f gui=nocombine]])
vim.cmd([[highlight StatusSepAlt guibg=#34383f guifg=#6f7379 gui=nocombine]])

vim.cmd([[highlight StatusSolid guibg=#34383f guifg=#e7e7e7 gui=nocombine]])
vim.cmd([[highlight StatusClear guibg=None guifg=#e7e7e7 gui=nocombine]])

vim.cmd([[highlight StatusFilename guibg=None guifg=#e7e7e7 gui=nocombine]])
vim.cmd([[highlight StatusFiletype guibg=None guifg=#e7e7e7 gui=nocombine]])

-- 'arrow' | 'rounded' | 'blank'
local active_sep = "arrow"

-- add more if needed
M.separators = {
    arrow = {
        left = "",
        left_alt = "",
        right = "",
        right_alt = "",
    },
    rounded = {
        left = "",
        left_alt = "",
        right = "",
        right_alt = "",
    },
    blank = {
        left = "",
        left_alt = "",
        right = "",
        right_alt = "",
    },
}

-- highlight groups
M.colors = {
    default = "%#StatusLine#",
    title_left = "%#StatusTitleL#",
    title_right = "%#StatusTitleR#",
    sep_left = "%#StatusSep#",
    sep_left_alt = "%#StatusSepAlt#",
    sep_right = "%#StatusSep#",
    sep_right_alt = "%#StatusSepAlt#",

    solid = "%#StatusSolid#",
    clear = "%#StatusClear#",
}

M.with_padding = function(str)
    return " " .. str .. " "
end

M.trunc_width = setmetatable({
    mode = 80,
    git_status = 90,
    filename = 140,
    line_col = 60,
}, {
    __index = function()
        return 80
    end,
})

M.is_truncated = function(_, width)
    local current_width = api.nvim_win_get_width(0)
    return false
end

M.get_title = function(_)
    return {
        left = " Neo",
        right = "vim ",
    }
end

M.get_git_status = function(self)
    -- use fallback because it doesn't set this variable on the initial `BufEnter`
    local signs = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
    local is_head = signs.head ~= ""
    local output = ""

    if self:is_truncated(self.trunc_width.git_status) then
        output = is_head and string.format("%s", signs.head or "") or ""
    end

    if not is_head then
        return ""
    end

    output = string.format("(%s) +%s ~%s -%s", signs.head, signs.added, signs.changed, signs.removed)

    return self.with_padding(output)
end

M.get_lsp_diagnostic = function(self)
    local result = {}
    local severities = vim.diagnostic.severity
    local levels = {
        errors = severities.ERROR,
        warnings = severities.WARN,
        info = severities.INFO,
        hints = severities.HINT,
    }

    for k, level in pairs(levels) do
        local total = 0
        local diag_res = vim.diagnostic.get(0, { severity = level })
        for _ in pairs(diag_res) do
            total = total + 1
        end
        result[k] = total
    end

    if self:is_truncated(120) then
        return " "
    else
        local output = string.format(
            " %s  %s",
            result["errors"] or 0,
            result["warnings"] or 0,
            result["info"] or 0,
            result["hints"] or 0
        )
        return self.with_padding(output)
    end
end

M.get_filename = function(self)
    if self:is_truncated(self.trunc_width.filename) then
        return self.with_padding("%<%f")
    end
    return self.with_padding("%<%F")
end

M.get_filetype = function(self)
    local file_name, file_ext = fn.expand("%:t"), fn.expand("%:e")
    local filetype = vim.bo.filetype

    if filetype == "" then
        return ""
    end

    local icon = require("nvim-web-devicons").get_icon(file_name, file_ext, { default = true })
    local output = string.format("%s %s", icon, filetype):lower()
    return self.with_padding(output)
end

M.get_line_col = function(self)
    if self:is_truncated(self.trunc_width.line_col) then
        return self.with_padding("%l:%c")
    end
    return self.with_padding("Ln %l, Col %c")
end

M.get_session_status = function(_)
    return "%{ObsessionStatus(' S ','')}"
end

M.value = function(self)
    local colors = self.colors

    local title_left = colors.title_left .. self:get_title().left
    local title_right = colors.title_right .. self:get_title().right
    local sep_left = colors.sep_left .. self.separators[active_sep].left
    local sep_left_alt = colors.sep_left_alt .. self.separators[active_sep].left_alt
    local sep_right = colors.sep_right .. self.separators[active_sep].right
    local sep_right_alt = colors.sep_right_alt .. self.separators[active_sep].right_alt

    local layout = {
        left = {
            {
                self:get_git_status(),
                colors.solid,
            },
            {
                self:get_lsp_diagnostic(),
                colors.solid,
            },
        },
        center = {
            {
                self:get_filename(),
                colors.clear,
            },
            {
                "%=",
                "",
            },
        },
        right = {
            {
                self:get_session_status(),
                colors.solid,
            },
            {
                self:get_filetype(),
                colors.solid,
            },
            {
                self:get_line_col(),
                colors.solid,
            },
        },
    }

    local tabline = {}

    for i, item in ipairs(layout.left) do
        if item[1] ~= "" then
            table.insert(tabline, item[2] .. item[1])
            if i ~= #layout.left then
                table.insert(tabline, sep_left_alt)
            end
        end
    end
    table.insert(tabline, sep_left)

    for _, item in ipairs(layout.center) do
        table.insert(tabline, item[2] .. item[1])
    end

    table.insert(tabline, sep_right)
    for i, item in ipairs(layout.right) do
        if item[1] ~= "" then
            table.insert(tabline, item[2] .. item[1])
            if i ~= #layout.right then
                table.insert(tabline, sep_right_alt)
            end
        end
    end

    return table.concat(vim.list_extend({
        colors.default,
        title_left,
        title_right,
    }, tabline))
end

Statusline = setmetatable(M, {
    __call = function(statusline, key)
        if key == "value" then
            return statusline:value()
        end
    end,
})

api.nvim_exec(
    [[
    set showtabline=2
    set statusline=
    set tabline=%!v:lua.Statusline('value')
]],
    false
)
