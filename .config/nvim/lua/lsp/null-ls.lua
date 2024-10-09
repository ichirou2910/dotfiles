local ok, null_ls = pcall(require, "null-ls")
if not ok then
    return
end

local command_resolver = require("null-ls.helpers.command_resolver")

local sources = {
    -- Diagnostics
    require("none-ls.diagnostics.eslint_d"),
    require("none-ls-shellcheck.diagnostics").with({ diagnostics_format = "#{m} [#{c}]" }),

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
    -- require("mason-null-ls").setup({
    --     ensure_installed = ensure_installed,
    --     automatic_installation = false,
    --     automatic_setup = false,
    -- })

    null_ls.setup({ sources = sources, debounce = 150 })
end

return M
