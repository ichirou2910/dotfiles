local map = vim.keymap.set

local function run_search(cmd)
    local o = vim.fn.systemlist(cmd)
    if not (o and #o > 0) then
        return false
    end

    vim.cmd("enew")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, o)
    vim.bo.buftype = "nofile"
    vim.bo.bufhidden = "wipe"
    vim.bo.swapfile = false
    return true
end

local function scratch_to_quickfix()
    local items = {}
    local bufnr = vim.api.nvim_get_current_buf()
    for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
        if line ~= "" then
            local f, lnum, text = line:match("^([^:]+):(%d+):(.*)$")
            if f and lnum then
                table.insert(items, { filename = vim.fn.fnamemodify(f, ":p"), lnum = lnum, text = text, })
            else
                lnum, text = line:match("^(%d+):(.*)$")
                if lnum and text then
                    table.insert(items, { filename = vim.fn.bufname(vim.fn.bufnr("#")), lnum = lnum, text = text, })
                else
                    table.insert(items, { filename = vim.fn.fnamemodify(line, ":p") })
                end
            end
        end
    end
    vim.api.nvim_buf_delete(bufnr, { force = true })
    vim.fn.setqflist(items, "r")
    vim.cmd("copen")
end

vim.api.nvim_create_user_command("FileSearch", function(opts)
    local path = opts.bang and vim.fn.expand("%:p:h") or vim.fn.getcwd()
    local args = "-path '*.git*' -prune -o"
    run_search("find " .. vim.fn.shellescape(path) .. " " .. args .. " " .. " -name " .. "'*" .. opts.args .. "*' -print")
end, { nargs = "+", bang = true })

vim.api.nvim_create_user_command("TextSearch", function(opts)
    local path = opts.bang and vim.fn.expand("%:p:h") or vim.fn.getcwd()
    local args = "--glob '!.git/**'"
    if opts.bang then
        args = args .. " --no-ignore "
    end
    local cmd = "rg --vimgrep -i -n " .. args .. " '" .. opts.args .. "' " .. path
    run_search(cmd)
end, { nargs = "+", bang = true })

map('n', '<leader>b', function()
    local qf_list = {}
    for _, buf in ipairs(vim.fn.getbufinfo()) do
        if buf.listed == 1 then
            table.insert(qf_list, {
                filename = buf.name ~= '' and buf.name or '[No Name]',
                text = ':' .. buf.bufnr
            })
        end
    end
    vim.fn.setqflist(qf_list, 'r')
    vim.cmd('copen')
end, {desc = "Buffer List"})

map("n", "<leader>x", scratch_to_quickfix, { desc = "Convert to Quickfix" })
map("n", "<leader>ff", function() vim.ui.input({ prompt = "> " }, function(query) if query then vim.cmd("FileSearch " .. query) end end) end, { desc = "Find Files" })
map("n", "<leader>fF", function() vim.ui.input({ prompt = "> " }, function(query) if query then vim.cmd("FileSearch! " .. query) end end) end, { desc = "Find Files (All)" })
map("n", "<leader>fa", function() vim.ui.input({ prompt = "> " }, function(query) if query then vim.cmd("TextSearch " .. query) end end) end, { desc = "Find Text" })
map("n", "<leader>fA", function() vim.ui.input({ prompt = "> " }, function(query) if query then vim.cmd("TextSearch! " .. query) end end) end, { desc = "Find Text (All)" })

map("n", "<leader>/", function()
  vim.ui.input({ prompt = "> " }, function(pattern)
    if not pattern or pattern == "" then return end
    run_search("grep -n '" .. pattern .. "' " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)))
  end)
end, { desc = "Search Current File" })

map("n", "<space>c", function()
    vim.ui.input({ prompt = "> " }, function(c)
        if c and c~="" then
            vim.cmd("noswapfile vnew | setlocal buftype=nofile bufhidden=wipe")
            vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
        end
    end)
end, { desc = "Run Command" })
