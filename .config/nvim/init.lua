local autocmd = vim.api.nvim_create_autocmd
local o = vim.opt

vim.g.mapleader = " "

-- OPTIONS
o.wrap = false -- Display long lines as just one line
o.equalalways = false -- Prevent auto balance split size when split
o.tabstop = 4 -- Insert 4 spaces for a tab
o.shiftwidth = 4 -- Change the number of space characters inserted for indentation
o.smarttab = true -- Makes tabbing smarter will realize you have 2 vs 4
o.ignorecase = true -- Ignore case, must use for smartcase to work
o.smartcase = true -- Smart case-insensitve/-sensitive search detection
o.expandtab = true -- Converts tabs to spaces
o.smartindent = true -- Makes indenting smart
o.autoindent = true -- Good auto indent
o.rnu = true
o.number = true
o.cursorline = true
o.updatetime = 300
o.completeopt = { "menuone", "noselect" }
o.clipboard:append("unnamedplus")

vim.opt.grepprg = "rg --vimgrep --no-ignore-parent --glob='!.git/**' -- $*"

function _G.f(cmd_arg) return vim.fn.systemlist("rg --files | rg " .. cmd_arg) end
vim.o.findfunc = 'v:lua.f'

-- PLUGINS
vim.pack.add({
    "https://github.com/zbirenbaum/copilot.lua",
    "https://github.com/echasnovski/mini.diff",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/kylechui/nvim-surround",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/nvim-treesitter/nvim-treesitter-context",
    "https://github.com/yioneko/nvim-vtsls",
    "https://github.com/tpope/vim-fugitive",
})

-- PLUGIN CONFIGURATION
require("copilot").setup({
    panel = { enabled = false },
    copilot_node_command = "/home/ichirou2910/.nvm/versions/node/v20.18.1/bin/node",
})

require("mini.diff").setup()
require("nvim-surround").setup()

local ts_parsers = {
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
}
local nts = require("nvim-treesitter")
nts.install(ts_parsers)
autocmd("PackChanged", {
	callback = function(args)
		local spec = args.data.spec
		if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
			vim.notify("nvim-treesitter was updated, updating parsers", vim.log.levels.INFO)
			vim.schedule(function()
				nts.update()
			end)
		end
	end,
})

autocmd("FileType", {
    callback = function(args)
        local ft = args.match
        local lang = vim.treesitter.language.get_lang(ft)
        if vim.treesitter.language.add(lang) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.treesitter.start()
        end
    end,
})

require("treesitter-context").setup({
    max_lines = 3,
    multiline_threshold = 1,
    separator = "-",
    min_window_height = 20,
    line_numbers = true,
})

require("lsp")
require("utils")
require("mappings")

-- Hide cursorline on inactive split
autocmd("WinEnter", { command = "set cul" })
autocmd("WinLeave", { command = "set nocul" })

-- Highlight when yanking (copying) text
autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("UserYankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.cmd([[
    highlight Normal guibg=None
]])
