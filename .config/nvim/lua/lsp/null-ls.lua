local ok, null_ls = pcall(require, "null-ls")

if not ok then
    return
end

local lsp_utils = require("lsp.utils")

local builtins = null_ls.builtins
local command_resolver = require("null-ls.helpers.command_resolver")

local sources = {
    -- Diagnostics
    builtins.diagnostics.eslint_d.with({
        condition = function(utils)
            return utils.root_has_file({
                ".eslintrc",
                ".eslintrc.json",
                ".eslintrc.yaml",
                ".eslintrc.cjs",
                ".eslintrc.js",
            })
        end,
    }),
    builtins.diagnostics.shellcheck.with({ diagnostics_format = "#{m} [#{c}]" }),

    -- Format
    builtins.formatting.prettierd.with({
        filetypes = { "html", "markdown", "scss", "css" },
        dynamic_command = command_resolver.from_node_modules(),
    }),
    builtins.formatting.shfmt,
    builtins.formatting.stylua,
    builtins.formatting.csharpier,
    builtins.formatting.jq,
    builtins.formatting.dart_format,

    -- Code actions
    builtins.code_actions.eslint_d.with({
        condition = function(utils)
            return utils.root_has_file({
                ".eslintrc",
                ".eslintrc.json",
                ".eslintrc.yaml",
                ".eslintrc.cjs",
                ".eslintrc.js",
            })
        end,
    }),
    builtins.code_actions.shellcheck,
}

local M = {}
M.setup = function()
    null_ls.setup({ sources = sources, on_attach = lsp_utils.lsp_attach, debounce = 150 })

    require("mason-null-ls").setup({
        ensure_installed = nil,
        automatic_installation = true,
        automatic_setup = false,
    })
end

return M
