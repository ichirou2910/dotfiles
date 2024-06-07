local userAugroup = vim.api.nvim_create_augroup("MyAutocmds", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
    group = userAugroup,
    command = "setlocal formatoptions-=cro",
    pattern = "*",
})

-- Hide cursorline on inactive split
vim.api.nvim_create_autocmd("WinEnter", {
    group = userAugroup,
    command = "set cul",
    pattern = "*",
})
vim.api.nvim_create_autocmd("WinLeave", {
    group = userAugroup,
    command = "set nocul",
    pattern = "*",
})

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = userAugroup,
    command = "silent! lua vim.highlight.on_yank{higroup='IncSearch', timeout=700}",
    pattern = "*",
})

-- Project notes
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = userAugroup,
    command = "set filetype=notes | set syntax=markdown",
    pattern = "*.notes",
})

-- C# LSP definition
vim.api.nvim_command([[
  autocmd FileType cs nnoremap <buffer> <leader>ld :lua vim.lsp.buf.definition()<CR>
]])

-- Disable semantic token
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
})
