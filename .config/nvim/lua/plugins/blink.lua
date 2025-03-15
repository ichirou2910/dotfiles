return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "fang2hou/blink-copilot",
        },
        version = "*",
        opts = {
            keymap = {
                preset = "super-tab",
            },
            completion = {
                list = {
                    selection = {
                        preselect = function(ctx)
                            return not require("blink.cmp").snippet_active({ direction = 1 })
                        end,
                    },
                },
            },
            signature = {
                enabled = true,
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                kind_icons = {
                    Copilot = "",
                },
            },
            sources = {
                default = { "copilot", "lsp", "dotnet", "path", "snippets", "buffer" },
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
                    dotnet = {
                        name = "easy-dotnet",
                        enabled = true,
                        module = "easy-dotnet.completion.blink",
                        score_offset = 10000,
                        async = true,
                    },
                },
            },
            snippets = {
                preset = "luasnip",
            },
        },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            copilot_node_command = vim.fn.system(
                "NIXPKGS_ALLOW_INSECURE=1 nix eval --impure --raw nixpkgs/e89cf1c932006531f454de7d652163a9a5c86668#nodejs_18"
            ) .. "/bin/node",
        },
    },
}
