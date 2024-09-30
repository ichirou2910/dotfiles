local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lsp_utils = require("lsp.utils")

local common_config = {
    capabilities = lsp_utils.get_capabilities(),
    on_attach = lsp_utils.lsp_attach,
    debounce_text_changes = 150,
}

-- servers with default config
local default_servers = { "html", "cssls", "gdscript" }

for _, s in pairs(default_servers) do
    lspconfig[s].setup(common_config)
end

-- servers handled by mason
local mason_servers = {
    lua_ls = {
        on_attach = lsp_utils.lsp_attach,
        capabilities = lsp_utils.get_capabilities(),
        flags = { debounce_text_changes = 150 },
        single_file_support = true,
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false,
                },
                completion = {
                    workspaceWord = true,
                    callSnippet = "Both",
                },
                misc = {
                    parameters = {
                        "--log-level=trace",
                    },
                },
                diagnostics = {
                    -- enable = false,
                    groupSeverity = {
                        strong = "Warning",
                        strict = "Warning",
                    },
                    groupFileStatus = {
                        ["ambiguity"] = "Opened",
                        ["await"] = "Opened",
                        ["codestyle"] = "None",
                        ["duplicate"] = "Opened",
                        ["global"] = "Opened",
                        ["luadoc"] = "Opened",
                        ["redefined"] = "Opened",
                        ["strict"] = "Opened",
                        ["strong"] = "Opened",
                        ["type-check"] = "Opened",
                        ["unbalanced"] = "Opened",
                        ["unused"] = "Opened",
                    },
                    unusedLocalExclude = { "_*" },
                },
                hint = {
                    enable = true,
                    arrayIndex = "Disable", -- "Enable", "Auto", "Disable"
                    await = true,
                    paramName = "Disable", -- "All", "Literal", "Disable"
                    paramType = false,
                    semicolon = "Disable", -- "All", "SameLine", "Disable"
                    setType = true,
                },
                format = {
                    enable = false,
                },
            },
        },
    },
}

-- Conditional lsp based on available dependencies in the host machine
local cond_deps = {
    phpactor = {
        cmd = "php",
        config = {
            on_attach = lsp_utils.lsp_attach,
            capabilities = lsp_utils.get_capabilities(),
        },
    },
}

for k, v in pairs(cond_deps) do
    if require("core.utils").is_command_available(v["cmd"]) then
        mason_servers[k] = v["config"]
    end
end

local mason_server_names = vim.tbl_keys(mason_servers)
mason.setup()
mason_lspconfig.setup_handlers({
    function(server_name)
        if vim.tbl_contains(mason_server_names, server_name) then
            lspconfig[server_name].setup(mason_servers[server_name])
        end
    end,
})
mason_lspconfig.setup({
    ensure_installed = mason_server_names,
})

-- c#: roslyn
local function lsp_roslyn()
    require("roslyn").setup({
        config = {
            on_attach = lsp_utils.lsp_attach,
            capabilities = lsp_utils.get_capabilities(),
            settings = {
                ["csharp|background_analysis"] = {
                    dotnet_analyzer_diagnostics_scope = false,
                },
                ["csharp|inlay_hints"] = {
                    csharp_enable_inlay_hints_for_implicit_object_creation = true,
                    csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                    csharp_enable_inlay_hints_for_types = true,
                    dotnet_enable_inlay_hints_for_indexer_parameters = true,
                    dotnet_enable_inlay_hints_for_literal_parameters = true,
                    dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                    dotnet_enable_inlay_hints_for_other_parameters = true,
                    dotnet_enable_inlay_hints_for_parameters = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                    dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                },
                ["csharp|code_lens"] = {
                    dotnet_enable_references_code_lens = true,
                },
            },
        },
    })
end

-- js/ts: tsserver
local function lsp_tsserver()
    vim.tbl_add_reverse_lookup = function(tbl)
        for k, v in pairs(tbl) do
            tbl[v] = k
        end
    end
    require("typescript-tools").setup({
        on_attach = lsp_utils.lsp_attach,
    })
end

lsp_roslyn()
lsp_tsserver()

-- null-ls
require("lsp.null-ls").setup()
require("lsp.flutter")
