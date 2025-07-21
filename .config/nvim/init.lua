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
o.signcolumn = "yes"
o.rnu = true
o.number = true -- Line numbers
o.cursorline = true -- Enable highlighting of the current line
o.updatetime = 300 -- Faster completion
o.completeopt = { "menuone", "noselect" }

-- PLUGINS
vim.pack.add({
  "https://github.com/fang2hou/blink-copilot",
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*") },
  "https://github.com/zbirenbaum/copilot.lua",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/echasnovski/mini.diff",
  "https://github.com/echasnovski/mini.extra",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/kylechui/nvim-surround",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  "https://github.com/nvim-treesitter/nvim-treesitter-context",
  "https://github.com/yioneko/nvim-vtsls",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/tpope/vim-eunuch",
  "https://github.com/tpope/vim-fugitive",
})

-- PLUGIN CONFIGURATION
require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    copilot_node_command = "/home/ichirou2910/.nvm/versions/node/v20.18.1/bin/node",
})

require("blink.cmp").setup({
    keymap = {
        preset = "super-tab",
    },
    signature = {
        enabled = true,
    },
    sources = {
        default = { "copilot", "lsp", "path", "snippets", "buffer" },
        providers = {
            copilot = {
                name = "copilot",
                module = "blink-copilot",
                score_offset = 100,
                async = true,
                opts = {
                    max_completions = 3,
                    max_attempts = 4,
                },
            },
        },
    },
})

require("mini.extra").setup()
require("mini.diff").setup()
require("nvim-surround").setup()

require("snacks").setup {
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    terminal = { enabled = true },
}

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
vim.api.nvim_create_autocmd("PackChanged", {
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

-- LSP
require("lsp")

require("mappings")
require("clipboard")

-- Hide cursorline on inactive split
autocmd("WinEnter", { command = "set cul" })
autocmd("WinLeave", { command = "set nocul" })
