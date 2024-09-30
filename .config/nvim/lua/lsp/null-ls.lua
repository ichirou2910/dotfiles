local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

local lsp_utils = require("lsp.utils")

local command_resolver = require("null-ls.helpers.command_resolver")

local sources = {
    -- Diagnostics
    require("none-ls.diagnostics.eslint_d"),
    require("none-ls-shellcheck.diagnostics").with({ diagnostics_format = "#{m} [#{c}]" }),

    -- Format
    null_ls.builtins.formatting.prettierd.with({
        filetypes = { "html", "markdown", "scss", "css" },
        dynamic_command = command_resolver.from_node_modules(),
    }),
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.csharpier.with({
        extra_args = { "--config-path", "~/.csharpierrc.json" },
    }),
    require("none-ls.formatting.jq"),
    null_ls.builtins.formatting.dart_format,

    -- Code actions
    require("none-ls.code_actions.eslint_d"),
    require("none-ls-shellcheck.code_actions"),
}

local M = {}
M.setup = function()
    -- Check for available dependencies to install accordingly tools
    local ensure_installed = {}
    local cond_deps = {
        csharpier = "dotnet",
        eslint_d = "npm",
        prettierd = "npm",
        jq = "jq",
    }
    for k, v in pairs(cond_deps) do
        if require("core.utils").is_command_available(v) then
            table.insert(ensure_installed, k)
        end
    end
    require("mason-null-ls").setup({
        ensure_installed = ensure_installed,
        automatic_installation = false,
        automatic_setup = false,
    })

    null_ls.setup({ sources = sources, on_attach = lsp_utils.lsp_attach, debounce = 150 })
end

return M
