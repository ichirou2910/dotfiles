vim.g.mapleader = " "

vim.opt.wrap = false
vim.opt.equalalways = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.rnu = true
vim.opt.number = true
vim.opt.completeopt:append("noselect")
vim.opt.winborder = "rounded"
vim.opt.grepprg = "rg --vimgrep --smart-case"

vim.pack.add({
    "https://github.com/zbirenbaum/copilot.lua",
    "https://github.com/echasnovski/mini.diff",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/yioneko/nvim-vtsls",
    "https://github.com/tpope/vim-fugitive",
})

require("mini.diff").setup()

require("mason").setup()
local mason_packages = {
    "lua-language-server",
    "copilot-language-server",
    "csharp-language-server",
    "vtsls",
}
local to_install = {}
for _, package in ipairs(mason_packages) do
    if not require("mason-registry").is_installed(package) then
        table.insert(to_install, package)
    end
end
if #to_install > 0 then
    require("mason.api.command").MasonInstall(to_install)
end

require("nvim-treesitter").install({
    "bash",
    "c",
    "c_sharp",
    "css",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "rust",
    "typescript",
    "vim",
})

-- Don't copy the replaced text after pasting in visual mode
vim.keymap.set("v", "p", '"_dP')

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d')

vim.keymap.set("n", "<leader>n", ":noh<CR>", { desc = "No Highlight" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("UserYankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.lsp.enable({ "lua_ls", "vtsls", "csharp_ls" })

require("copilot").setup({
    panel = { enabled = false },
    server_opts_overrides = {
        cmd = {
            vim.fn.expand("~/.local/share/nvim/mason/bin/copilot-language-server"),
            "--stdio",
        },
    },
})
