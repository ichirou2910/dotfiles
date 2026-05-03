vim.g.mapleader = vim.keycode("<space>")

vim.opt.nu = true
vim.opt.rnu = true
vim.opt.wrap = false
vim.opt.equalalways = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.completeopt = "menu,noinsert,popup,fuzzy"
vim.opt.completeitemalign = "kind,abbr,menu"
vim.opt.foldenable = false
vim.opt.showmode = false

-- Don't continue comments on new lines
vim.cmd('autocmd BufEnter * set formatoptions-=cro')
vim.cmd('autocmd BufEnter * setlocal formatoptions-=cro')

require('vim._core.ui2').enable({})

vim.pack.add({
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-mini/mini.bufremove",
  "https://github.com/nvim-mini/mini.cmdline",
  "https://github.com/nvim-mini/mini.completion",
  "https://github.com/nvim-mini/mini.diff",
  "https://github.com/nvim-mini/mini.extra",
  "https://github.com/nvim-mini/mini.files",
  "https://github.com/nvim-mini/mini.pick",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/GustavEikaas/easy-dotnet.nvim",
  "https://github.com/yioneko/nvim-vtsls",
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/mfussenegger/nvim-dap",
  "https://github.com/igorlfs/nvim-dap-view",
  "https://github.com/nmac427/guess-indent.nvim",
  "https://github.com/AvengeMedia/base46",
})

vim.cmd("packadd nohlsearch")
vim.cmd("packadd nvim.undotree")
vim.cmd("packadd nvim.difftool")

require("mini.bufremove").setup()
require("mini.cmdline").setup()
require("mini.completion").setup()
require("mini.diff").setup()
require("mini.files").setup()
require("mini.pick").setup {
  window = {
    config = {
      width = vim.o.columns
    }
  }
}
require("mini.extra").setup()
require('guess-indent').setup()

local ts = require("nvim-treesitter")
local parsers = {
  "bash",
  "c",
  "c_sharp",
  "css",
  "dart",
  "diff",
  "dockerfile",
  "glsl",
  "gitignore",
  "gitcommit",
  "hlsl",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "razor",
  "rust",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}
ts.install(parsers)

local patterns = {}
for _, parser in ipairs(parsers) do
  local parser_patterns = vim.treesitter.language.get_filetypes(parser)
  for _, pp in pairs(parser_patterns) do
    table.insert(patterns, pp)
  end
end

vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.wo.foldmethod = 'expr'

vim.api.nvim_create_autocmd('FileType', {
  pattern = patterns,
  callback = function()
    vim.treesitter.start()
  end,
})

-- Don't copy the replaced text after pasting in visual mode
vim.keymap.set("v", "p", '"_dP')

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d')

vim.keymap.set("n", "<leader>u", require("undotree").open)

vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>", { desc = "File Explorer" })
vim.keymap.set("n", "<leader>E", ":lua MiniFiles.open()<CR>", { desc = "File Explorer (Root)" })

vim.keymap.set("n", "<leader>q", ":lua MiniBufremove.delete()<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")

vim.keymap.set("n", "<leader>sf", ":Pick files<CR>")
vim.keymap.set("n", "<leader>sg", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>sr", ":Pick resume<CR>")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("UserYankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.lsp.enable({ "lua_ls", "vtsls" })

require("easy-dotnet").setup({
  background_scanning = false,
  lsp = {
    preload_roslyn = false,
    config = {
      settings = {
        ["csharp|background_analysis"] = {
          dotnet_compiler_diagnostics_scope = "openFiles"
        },
        ["csharp|inlay_hints"] = {
          csharp_enable_inlay_hints_for_implicit_object_creation = true,
          csharp_enable_inlay_hints_for_implicit_variable_types = true,
          csharp_enable_inlay_hints_for_lambda_parameter_types = true,
          csharp_enable_inlay_hints_for_types = true,
          dotnet_enable_inlay_hints_for_indexer_parameters = true,
          dotnet_enable_inlay_hints_for_literal_parameters = true,
          dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          dotnet_enable_inlay_hints_for_parameters = true,
        },
        ["csharp|code_lens"] = {
          dotnet_enable_references_code_lens = false,
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end

    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

    vim.keymap.set('n', 'gO', ':Pick lsp scope="document_symbol"<CR>', { buffer = 0 })
    vim.keymap.set('n', 'gr/', ':Pick lsp scope="workspace_symbol"<CR>', { buffer = 0 })

    vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition<CR>', { buffer = 0 })

    vim.keymap.set('n', 'grq', function() vim.diagnostic.setqflist() end, { buffer = 0 })
    vim.keymap.set('n', 'gK', function() vim.diagnostic.open_float() end, { buffer = 0 })
  end
})

-- Debugger keymaps
local dap = require("dap")
vim.keymap.set("n", "<F5>", dap.continue)
vim.keymap.set("n", "<F6>", dap.pause)
vim.keymap.set("n", "<S-F5>", dap.terminate)
vim.keymap.set("n", "<C-S-F5>", dap.run_last)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<S-F11>", dap.step_out)
vim.keymap.set("n", "<C-F11>", dap.run_to_cursor)
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint)
vim.keymap.set("n", "<S-F9>", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
vim.keymap.set("n", "gk", function()
  if dap.session() then
    require("dap.ui.widgets").hover()
  else
    vim.cmd.normal({ "gk", bang = true })
  end
end)

require("dap-view").setup({
  winbar = {
    default_section = "repl",
    controls = {
      enabled = true,
    }
  }
})
vim.keymap.set("n", "<C-S-Y>", require("dap-view").toggle, { desc = "Toggle Debug View" })

vim.cmd "colorscheme dms"
vim.cmd "hi! Normal guibg=NONE"
