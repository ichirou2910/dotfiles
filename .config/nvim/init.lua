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
    "https://github.com/seblyng/roslyn.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/stevearc/oil.nvim",
    "https://github.com/kevinhwang91/nvim-bqf",
    "https://github.com/mfussenegger/nvim-dap",
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
    "vtsls",
    "copilot-language-server",
    "netcoredbg",
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
require("roslyn").setup()

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

local dap = require("dap")

dap.adapters.netcoredbg = {
    type = 'executable',
    command = 'netcoredbg',
    args = { '--interpreter=vscode' }
}

dap.configurations.cs = (function()
    if vim.tbl_isempty(vim.fn.glob(vim.fn.getcwd() .. "/*.sln", true, true)) then
        return {}
    end

    local dap_config = {}

    local csproj_files = vim.fn.glob(vim.fn.getcwd() .. "**/*.csproj", true, true)
    for _, csproj in ipairs(csproj_files) do
        local project_name = vim.fn.fnamemodify(csproj, ":t:r")

        -- Determine the target framework from the .csproj file
        local csproj_content = vim.fn.readfile(csproj)
        local target_framework = "net6.0" -- Default framework
        for _, line in ipairs(csproj_content) do
            local tf = line:match("<TargetFramework>(.-)</TargetFramework>")
            if tf then
                target_framework = tf
                break
            end
        end

        -- Read launchSettings.json if it exists
        local launch_settings_path = vim.fn.fnamemodify(csproj, ":h") .. "/Properties/launchSettings.json"
        local launch_settings = {}
        if vim.fn.filereadable(launch_settings_path) == 1 then
            local content = vim.fn.readfile(launch_settings_path)
            launch_settings = vim.fn.json_decode(table.concat(content, "\n"))
        end

        -- Create a DAP configuration for each profile in launchSettings.json
        if launch_settings["profiles"] then
            for profile_name, profile in pairs(launch_settings["profiles"]) do
                local cwd = profile["workingDirectory"] or vim.fn.getcwd() .. "/" .. project_name
                table.insert(dap_config, {
                    type = "netcoredbg",
                    name = project_name .. " - " .. profile_name,
                    request = "launch",
                    program = function()
                        return profile["commandName"] == "Project" and
                            cwd .. "/bin/Debug/" .. target_framework .. "/" .. project_name .. ".dll" or
                            profile["executablePath"]
                    end,
                    env = profile["environmentVariables"],
                    args = { "--urls" .. (profile["applicationUrl"] or "http://localhost:5000") },
                    cwd = cwd,
                    stopAtEntry = false,
                })
            end
        end
    end

    return dap_config
end)()

vim.cmd "hi Normal guibg=None"
