vim.api.nvim_create_user_command("Note", function()
    vim.cmd([[topleft vnew project.notes | setlocal cursorline noswapfile winfixwidth nobuflisted bufhidden=hide ]])
end, {})
