local M = {}

local capabilities = require("lsp.utils").get_capabilities()

function M.setup()
    -- c#: roslyn
    local function lsp_roslyn()
        require("roslyn").setup({
            config = {
                capabilities = capabilities,
                settings = {
                    ["csharp|background_analysis"] = {
                        dotnet_analyzer_diagnostics_scope = "none",
                        dotnet_compiler_diagnostics_scope = "none",
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
            filewatching = false,
        })
    end

    lsp_roslyn()
end

return M
