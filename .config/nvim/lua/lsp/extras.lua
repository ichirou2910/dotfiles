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
        })
    end

    -- c#: dotnet
    local function lsp_dotnet()
        local dotnet = require("easy-dotnet")

        dotnet.setup({
            ---@param action "test" | "restore" | "build" | "run"
            terminal = function(path, action, args)
                local commands = {
                    run = function()
                        return string.format("dotnet run --project %s %s", path, args)
                    end,
                    test = function()
                        return string.format("dotnet test %s %s", path, args)
                    end,
                    restore = function()
                        return string.format("dotnet restore %s %s", path, args)
                    end,
                    build = function()
                        return string.format("dotnet build %s %s", path, args)
                    end,
                }

                local command = commands[action]()
                vim.cmd("lua Snacks.terminal.open('" .. command .. "')")
                -- vim.cmd("term " .. command)
            end,
            csproj_mappings = true,
            fsproj_mappings = true,
            auto_bootstrap_namespace = {
                --block_scoped, file_scoped
                type = "block_scoped",
                enabled = true,
            },
            picker = "snacks",
        })

        -- Example keybinding
        -- vim.keymap.set("n", "<C-p>", function()
        --     dotnet.run_project()
        -- end)
    end

    lsp_roslyn()
    lsp_dotnet()
end

return M
