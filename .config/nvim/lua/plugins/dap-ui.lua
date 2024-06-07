return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        config = function()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", circular = "↺" },
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.4 },
                            { id = "breakpoints", size = 0.2 },
                            { id = "stacks", size = 0.2 },
                            { id = "watches", size = 0.2 },
                        },
                        size = 60,
                        position = "left",
                    },
                    {
                        elements = {
                            "repl",
                            --[[ "console", ]]
                        },
                        size = 10,
                        position = "bottom",
                    },
                },
                floating = {
                    max_height = nil, -- These can be integers or a float between 0 and 1.
                    max_width = nil, -- Floats will be treated as percentage of your screen.
                },
            })

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
        end,
    },
}
