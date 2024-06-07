local rt = require("rust-tools")
local lsp_utils = require("lsp.utils")

local opts = {
    tools = { -- rust-tools options
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = false,
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
        hover_actions = {

            -- the border that is used for the hover window
            -- see vim.api.nvim_open_win()
            border = "solid",

            -- whether the hover action window gets automatically focused
            -- default: false
            auto_focus = true,
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- standalone file support
        standalone = true,
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = function(client, bufnr)
            lsp_utils.lsp_attach(client, bufnr)
            vim.keymap.set("n", "<leader>lh", rt.hover_actions.hover_actions, { buffer = bufnr })
            --[[ vim.keymap.set("n", "<leader>la", rt.code_action_group.code_action_group, { buffer = bufnr }) ]]
        end,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                imports = {
                    granularity = {
                        group = "module",
                    },
                    prefix = "self",
                },
                cargo = {
                    buildScripts = {
                        enable = true,
                    },
                },
                procMacro = {
                    enable = true,
                },
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },

    -- debugging stuff
    dap = {
        adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
        },
    },
}

rt.setup(opts)
