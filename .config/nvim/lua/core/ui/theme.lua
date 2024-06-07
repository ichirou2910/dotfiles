-- Activate highlighting
vim.api.nvim_command("syntax on")
if vim.fn.has("termguicolors") == 1 then
    vim.o.termguicolors = true
end

local ok, cyberdream = pcall(require, "cyberdream")
if not ok then
    return
end

require("cyberdream").setup({
    transparent = true,
    italic_comments = false,
    hide_fillchars = true,
    borderless_telescope = false,
    terminal_colors = true,
    theme = {
        highlights = {
            InclineNormal = { bg = "#3c4048" },
        },
    },
})
vim.cmd("colorscheme cyberdream")
