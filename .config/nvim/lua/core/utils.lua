---@class core.utils
local M = {}

---Converts a value to a string
---@param value any # any value that will be converted to a string
---@return string|nil # the tringified version of the value
local stringify = function(value)
    if value == nil then
        return nil
    elseif type(value) == "string" then
        return value
    elseif vim.tbl_islist(value) then
        return M.tbl_join(value, ", ")
    elseif type(value) == "table" then
        return vim.inspect(value)
    elseif type(value) == "function" then
        return stringify(value())
    else
        return tostring(value)
    end
end

--- Shows a notification
---@param msg any # the message to show
---@param type integer # the type of the notification
---@param opts? table # the options to pass to the notification
local notify = function(msg, type, opts)
    assert(msg ~= nil)

    vim.schedule(function()
        vim.notify(stringify(msg) or "", type, M.tbl_merge({ title = "Neovim" }, opts))
    end)
end

M.keymap = function(mode, keys, cmd, opt)
    local options = { noremap = true, silent = true }
    if opt then
        options = vim.tbl_extend("force", options, opt)
    end

    -- all valid modes allowed for mappings
    -- :h map-modes
    local valid_modes = {
        [""] = true,
        ["n"] = true,
        ["v"] = true,
        ["s"] = true,
        ["x"] = true,
        ["o"] = true,
        ["!"] = true,
        ["i"] = true,
        ["l"] = true,
        ["c"] = true,
        ["t"] = true,
    }

    -- helper function for M.map
    -- can gives multiple modes and keys
    local function map_wrapper(_mode, lhs, rhs, _options)
        if type(lhs) == "table" then
            for _, key in ipairs(lhs) do
                map_wrapper(_mode, key, rhs, _options)
            end
        else
            if type(_mode) == "table" then
                for _, m in ipairs(_mode) do
                    map_wrapper(m, lhs, rhs, _options)
                end
            else
                if valid_modes[_mode] and lhs and rhs then
                    vim.api.nvim_set_keymap(_mode, lhs, rhs, _options)
                else
                    _mode, lhs, rhs = _mode or "", lhs or "", rhs or ""
                    print(
                        "Cannot set mapping [ mode = '"
                            .. _mode
                            .. "' | key = '"
                            .. lhs
                            .. "' | cmd = '"
                            .. rhs
                            .. "' ]"
                    )
                end
            end
        end
    end

    map_wrapper(mode, keys, cmd, options)
end

M.highlight = function(group, hl_table)
    vim.api.nvim_set_hl(0, group, hl_table)
end

--- Converts a value to a list
---@param value any # any value that will be converted to a list
---@return any[] # the listified version of the value
M.to_list = function(value)
    if value == nil then
        return {}
    elseif vim.tbl_islist(value) then
        return value
    elseif type(value) == "table" then
        local list = {}
        for _, item in ipairs(value) do
            table.insert(list, item)
        end

        return list
    else
        return { value }
    end
end

M.isEmpty = function(src)
    return src == nil or src == ""
end

--- Joins all items in a list into a string
---@param items table # the list of items to join
---@param separator string|nil # the separator to use between items
---@return string|nil # the joined string
function M.tbl_join(items, separator)
    if not vim.tbl_islist(items) then
        return stringify(items)
    end

    local result = ""

    for _, item in ipairs(items) do
        if #result > 0 and separator ~= nil then
            result = result .. separator
        end

        result = result .. stringify(item)
    end

    return result
end

--- Merges multiple tables into one
---@vararg table|nil # the tables to merge
---@return table # the merged table
function M.tbl_merge(...)
    local all = {}

    for _, a in ipairs({ ... }) do
        if a then
            table.insert(all, a)
        end
    end

    if #all == 0 then
        return {}
    elseif #all == 1 then
        return all[1]
    else
        return vim.tbl_deep_extend("force", unpack(all))
    end
end

local group_index = 0

--- Creates an auto command that triggers on a given list of events
---@param events string|string[] # the list of events to trigger on
---@param callback function # the callback to call when the event is triggered
---@param target table|string|number|nil # the target to trigger on
---@return number # the group id of the created group
function M.on_event(events, callback, target)
    assert(type(callback) == "function")

    events = M.to_list(events)
    target = M.to_list(target)

    -- create group
    local group_name = "user_" .. group_index
    group_index = group_index + 1
    local group = vim.api.nvim_create_augroup(group_name, { clear = true })

    local opts = {
        callback = function(evt)
            callback(evt, group)
        end,
        group = group,
    }

    -- decide on the target
    if type(target) == "number" then
        opts.buffer = target
    elseif target then
        opts.pattern = target
    end

    -- create auto command
    vim.api.nvim_create_autocmd(events, opts)

    return group
end

--- Creates an auto command that triggers on a given list of user events
---@param events string|table # the list of events to trigger on
---@param callback function # the callback to call when the event is triggered
---@return number # the group id of the created group
M.on_user_event = function(events, callback)
    events = M.to_list(events)
    return M.on_event("User", function(evt)
        callback(evt.match, evt)
    end, events)
end

--- Shows a notification with the INFO type
---@param msg any # the message to show
M.info = function(msg)
    notify(msg, vim.log.levels.INFO)
end

--- Shows a notification with the WARN type
---@param msg any # the message to show
M.warn = function(msg)
    notify(msg, vim.log.levels.WARN)
end

--- Shows a notification with the ERROR type
---@param msg any # the message to show
M.error = function(msg)
    notify(msg, vim.log.levels.ERROR)
end

--- Checks if a plugin is available
---@param name string # the name of the plugin
---@return boolean # true if the plugin is available, false otherwise
M.has_plugin = function(name)
    assert(type(name) == "string" and name ~= "")

    if package.loaded["lazy"] then
        return require("lazy.core.config").spec.plugins[name] ~= nil
    end

    return false
end

--- Joins two paths
---@param part1 string # the first part of the path
---@param part2 string # the second part of the path
---@return string # the joined path
local join_paths = function(part1, part2)
    part1 = part1:gsub("([^/])$", "%1/"):gsub("//", "/")
    part2 = part2:gsub("^/", "")

    return part1 .. part2
end

--- Joins multiple paths
---@vararg string|nil # the paths to join
---@return string|nil # the joined path or nil if none of the paths are valid
M.join_paths = function(...)
    ---@type string|nil
    local acc
    for _, part in ipairs({ ... }) do
        if part ~= nil then
            if acc then
                acc = join_paths(acc, part)
            else
                acc = part
            end
        end
    end

    return acc
end

M.is_command_available = function (cmd)
    local result = os.execute("command -v " .. cmd .. " > /dev/null 2>&1")
    return result == 0
end

return M
