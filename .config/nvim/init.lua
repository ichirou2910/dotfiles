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
vim.opt.signcolumn = "yes"
vim.opt.completeopt = "menuone,noselect,fuzzy,nosort"
vim.opt.winborder = "rounded"
vim.opt.grepprg = "rg --vimgrep --hidden -g '!.git/*'"

function _G.RgFindFiles(cmdarg, cmdcomplete)
    local fnames = vim.fn.systemlist('rg --files --hidden --color=never --glob="!.git"')
    if #cmdarg == 0 then
        return fnames
    else
        return vim.fn.matchfuzzy(fnames, cmdarg)
    end
end

vim.o.findfunc = 'v:lua.RgFindFiles'

vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/echasnovski/mini.diff",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    "https://github.com/yioneko/nvim-vtsls",
    "https://github.com/GustavEikaas/easy-dotnet.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/kevinhwang91/nvim-bqf",
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/igorlfs/nvim-dap-view",
    "https://github.com/f-person/auto-dark-mode.nvim",
    "https://github.com/rose-pine/neovim"
})

require("oil").setup()
require("mini.diff").setup()
require("quickfix")

require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry", -- for roslyn
    },
})
local mason_packages = {
    "lua-language-server",
    "roslyn",
    "netcoredbg",
    "vtsls",
    "copilot-language-server",
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

vim.keymap.set("n", "<leader>e", ":Oil<CR>", { desc = "File Explorer" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("UserYankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.lsp.enable({ "lua_ls", "vtsls", "copilot" })

require("easy-dotnet").setup({
    diagnostics = {
        setqflist = true,
    },
    debugger = {
        bin_path = "netcoredbg",
    },
})
require("easy-dotnet.netcoredbg").register_dap_variables_viewer()

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local bufnr = args.buf
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, bufnr) then
            vim.lsp.inline_completion.enable(true, { bufnr = bufnr })

            vim.keymap.set('i', '<M-l>', vim.lsp.inline_completion.get, { buffer = bufnr })
            vim.keymap.set('i', '<M-]>', vim.lsp.inline_completion.select, { buffer = bufnr })
        end
    end
})

-- Debugger keymaps
local dap = require("dap")
vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
vim.keymap.set("n", "<F6>", dap.pause, { desc = "Pause Debugging" })
vim.keymap.set("n", "<F17>", dap.terminate, { desc = "Stop Debugging" })   -- Shift+F5
vim.keymap.set("n", "<F41>", dap.run_last, { desc = "Restart Debugging" }) -- Ctrl+Shift+F5
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<F23>", dap.step_out, { desc = "Step Out" })           -- Shift+F11
vim.keymap.set("n", "<F35>", dap.run_to_cursor, { desc = "Run to Cursor" }) -- Ctrl+F11
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<F21>", function()                                     -- Shift+F9
    dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set Conditional Breakpoint" })
vim.keymap.set("n", "K", function()
    if not dap.session() then
        vim.lsp.buf.hover()
        return
    end
    require("dap.ui.widgets").hover()
end, { desc = "Inspect Expression" })

require("dap-view").setup({
    winbar = {
        controls = {
            enabled = true,
        }
    }
})

require("rose-pine").setup({
    dark_variant = "moon",
    styles = {
        transparency = true
    }
})
vim.cmd "colorscheme rose-pine"

require("auto-dark-mode").setup()
