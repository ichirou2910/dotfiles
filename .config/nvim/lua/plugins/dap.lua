return {
    {
        "mfussenegger/nvim-dap",
        event = "BufWinEnter",
        module = "dap",
        config = function()
            local dap = require("dap")

            -- Setup
            vim.fn.sign_define("DapBreakpoint", {
                text = "",
                texthl = "DiagnosticError",
                linehl = "",
                numhl = "",
            })
            vim.fn.sign_define("DapStopped", {
                text = "",
                texthl = "DiagnosticWarn",
                linehl = "DapStopped",
                numhl = "",
            })
            vim.fn.sign_define("DapBreakpointRejected", {
                text = "",
                texthl = "DiagnosticErros",
                linehl = "",
                numhl = "",
            })
            vim.fn.sign_define("DapLogPoint", {
                text = "",
                texthl = "DiagnosticInfo",
                linehl = "",
                numhl = "",
            })

            -- Adapters
            -- .NET Core
            dap.adapters.netcoredbg = function(cb, config)
                if config.preLaunchTask then
                    vim.loop.chdir(config.cwd)
                    vim.fn.system(config.preLaunchTask)
                    -- Doesn't fire debugger if preLaunchTask failed
                    if vim.v.shell_error ~= 0 then
                        vim.notify("Pre-launch Task failed.")
                        return
                    end
                end
                cb({
                    type = "executable",
                    command = vim.fn.exepath("netcoredbg"),
                    args = { "--interpreter=vscode" },
                })
            end

            -- C/C++/Rust
            dap.adapters.lldb = {
                type = "executable",
                command = "/usr/bin/lldb-vscode", -- adjust as needed
                name = "lldb",
            }

            -- Godot
            dap.adapters.godot = {
                type = "server",
                host = "127.0.0.1",
                port = 6006,
            }

            dap.adapters.php = {
                type = "executable",
                command = "/home/ichirou2910/.local/share/nvim/mason/bin/php-debug-adapter",
            }

            -- Configuration
            -- C/C++
            dap.configurations.cpp = {
                {
                    name = "Launch",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    args = {},
                    runInTerminal = false,
                },
            }
            dap.configurations.c = dap.configurations.cpp

            -- C#
            dap.configurations.cs = (function()
                -- Check if we're in a C# project
                if vim.tbl_isempty(vim.fn.glob(vim.fn.getcwd() .. "/*.sln", true, true)) then
                    return {}
                end

                local dap_config = {}
                -- C# Debug Profiles
                local files = vim.fn.findfile("launchSettings.json", vim.fn.getcwd() .. "/**", -1)
                for _, file in ipairs(files) do
                    local parts = vim.fn.split(file, "/")
                    local project = parts[1]
                    local fd = vim.loop.fs_open(vim.fn.getcwd() .. "/" .. file, "r", 438)
                    if fd then
                        local stat = vim.loop.fs_fstat(fd)
                        local config_string = vim.loop.fs_read(fd, stat.size, 0)
                        local dap_data = vim.fn.json_decode(config_string)["profiles"]
                        local cwd = vim.fn.getcwd() .. "/" .. project
                        for profile, profile_data in pairs(dap_data) do
                            local config = {
                                type = "netcoredbg",
                                name = project .. " [" .. profile .. "]",
                                request = "launch",
                                preLaunchTask = "dotnet build",
                                cwd = cwd,
                                program = cwd .. "/bin/Debug/net6.0/" .. project .. ".dll",
                                env = profile_data["environmentVariables"],
                            }
                            table.insert(dap_config, config)
                        end
                    end
                end
                return dap_config
            end)()

            -- Godot
            dap.configurations.gdscript = {
                {
                    type = "godot",
                    request = "launch",
                    name = "Launch scene",
                    project = "${workspaceFolder}",
                    launch_scene = true,
                },
            }

            dap.configurations.php = {
                {
                    type = "php",
                    request = "launch",
                    name = "Listen for Xdebug",
                    port = 9090,
                    pathMappings = {
                        ["/app"] = "${workspaceFolder}",
                    },
                },
            }

            dap.defaults.fallback.switchbuf = "useopen,uselast"
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup({})
        end,
    },
}
