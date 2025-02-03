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

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("UserYankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
