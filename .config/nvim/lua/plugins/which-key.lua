return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
            plugins = {
                spelling = { enabled = false, suggestions = 20 }, -- use which-key for spelling hints
            },
            win = {
                border = "rounded",
            },
        },
        config = function()
            local wk = require("which-key")

            local n_mappings = {
                [";"] = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
                ["="] = { "<C-W>=", "Balance windows" },
                ["`"] = { "<cmd>lua require('harpoon'):list():add()<cr>", "Mark" },
                a = { "<cmd>lua require('fzf-lua').buffers()<cr>", "Buffers" },
                e = { ":NnnPicker %:p:h<CR>", "Explorer @current" },
                E = { ":NnnPicker<CR>", "Explorer" },
                n = { ":noh<CR>", "No Highlight" },
                w = "List marks",

                b = {
                    name = "Buffer",
                    ["1"] = { "<cmd>lua require('harpoon'):list():select(1)<cr>", "Mark 1" },
                    ["2"] = { "<cmd>lua require('harpoon'):list():select(2)<cr>", "Mark 2" },
                    ["3"] = { "<cmd>lua require('harpoon'):list():select(3)<cr>", "Mark 3" },
                    ["4"] = { "<cmd>lua require('harpoon'):list():select(4)<cr>", "Mark 4" },
                    a = { "<cmd>lua require('harpoon'):list():add()<cr>", "Mark" },
                    p = { ":BufferPin<CR>", "Pin" },
                    s = {
                        name = "Sort",
                        b = { "<cmd>BufferOrderByBufferNumber<cr>", "By Buffer Number" },
                        d = { "<cmd>BufferOrderByDirectory<cr>", "By Directory" },
                        l = { "<cmd>BufferOrderByLanguage<cr>", "By Language" },
                        w = { "<cmd>BufferOrderByWindowNumber<cr>", "By Window Number" },
                    },
                },

                d = {
                    name = "Debug",
                    b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
                    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run to Cursor" },
                    d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
                    f = { "<cmd>lua require'dapui'.float_element()<cr>", "Elements" },
                    g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
                    i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
                    k = {
                        function()
                            require("dap.ui.widgets").hover()
                        end,
                        "Inspect",
                    },
                    o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
                    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
                    q = { "<cmd>lua require'dap'.terminate()<cr>", "Terminate" },
                    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
                    R = { "<cmd>lua require'dap'.restart()<cr>", "Restart" },
                    s = { "<cmd>lua require'dap'.continue()<cr>", "Start / Continue" },
                    t = {
                        "<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<cr>",
                        "Toggle Breakpoint",
                    },
                    u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
                    z = { "<cmd>lua require'dapui'.toggle()<cr>", "Toggle UI" },
                },

                f = {
                    name = "Find",
                    a = { "<cmd>lua require('fzf-lua').live_grep()<cr>", "Text" },
                    b = { "<cmd>lua require('fzf-lua').buffers()<cr>", "Buffers" },
                    c = { "<cmd>lua require('fzf-lua').git_commits()<cr>", "Commits" },
                    C = { "<cmd>lua require('fzf-lua').git_bcommits()<cr>", "Buffer Commits" },
                    f = { "<cmd>lua require('fzf-lua').files()<cr>", "Files" },
                    F = { "<cmd>lua require('telescope').extensions.file_browser.file_browser()<cr>", "File Browser" },
                    l = { "<cmd>lua require('fzf-lua').live_grep_last()<cr>", "Last search word" },
                    n = {
                        "<cmd>Noice telescope<CR>",
                        "Notifications",
                    },
                    r = { "<cmd>lua require('spectre').open({is_close = true})<cr>", "Replace" },
                    s = { "<cmd>lua require('fzf-lua').search_history()<cr>", "Search history" },
                    w = { "<cmd>lua require('fzf-lua').grep_cword()<cr>", "Word" },
                },

                g = {
                    name = "Git",
                    a = { "<cmd>Git add %<CR>", "Add current" },
                    A = { "<cmd>Git add .<CR>", "Add all" },
                    b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Toggle blame" },
                    c = { "<cmd>Git commit<CR>", "Commit" },
                    d = { "<cmd>Gitsigns diffthis<CR>", "Diff this" },
                    D = { "<cmd>lua require('gitsigns').diffthis('~')<CR>", "Diff last commit" },
                    f = { "<cmd>Git fetch<CR>", "Fetch" },
                    l = { "<cmd>Git log<CR>", "Log" },
                    p = { "<cmd>Git push<CR>", "Push" },
                    P = { "<cmd>Git pull<CR>", "Pull" },
                    r = { "<cmd>GRemove<CR>", "Remove" },
                    x = { "<cmd>Git restore %<CR>", "Restore" },
                },

                h = {
                    name = "Git hunks",
                    d = "Diff this",
                    D = "Diff this",
                    p = "Preview",
                    r = "Reset",
                    R = "Reset buffer",
                    s = "Stage",
                    S = "Reset buffer",
                    u = "Undo staged",
                },

                l = {
                    name = "LSP",
                    a = { "<cmd>lua require('fzf-lua').lsp_code_actions()<cr>", "Code Action" },
                    c = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Code Lens" },
                    d = {
                        "<cmd>lua require('fzf-lua').lsp_definitions({ jump_to_single_result = true })<cr>",
                        "Definition",
                    },
                    D = { "<cmd>lua require('fzf-lua').lsp_declarations()<cr>", "Declaration" },
                    f = "Format",
                    i = {
                        "<cmd>lua require('fzf-lua').lsp_implementations({ jump_to_single_result = true })<cr>",
                        "Implementation",
                    },
                    I = {
                        "<cmd>Trouble diagnostics toggle<cr>",
                        "Diagnostics",
                    },
                    k = "Open float",
                    l = { "<cmd>Trouble loclist<cr>", "Loclist" },
                    o = { "<cmd>lua require('fzf-lua').lsp_document_symbols()<cr>", "Document Symbols" },
                    p = {
                        name = "Peek",
                        d = { "<cmd>lua require('goto-preview').goto_preview_definition()<cr>", "Definition" },
                        i = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Implementation" },
                    },
                    q = { "<cmd>Trouble quickfix<cr>", "Quickfix" },
                    r = {
                        "<cmd>lua require('fzf-lua').lsp_references({ ignore_current_line = true })<cr>",
                        "References",
                    },
                    R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
                    x = { "<cmd>TroubleToggle<cr>", "Toggle trouble" },
                    z = { "<cmd>LspInfo<cr>", "Info" },
                    ["["] = { "<cmd>lua require('fzf-lua').lsp_incoming_calls()<cr>", "Incoming Calls" },
                    ["]"] = { "<cmd>lua require('fzf-lua').lsp_outgoing_calls()<cr>", "Outgoing Calls" },
                },

                L = {
                    name = "LSP Tools",
                    f = {
                        "<cmd>Telescope flutter commands<cr>",
                        "Flutter",
                    },
                },

                p = {
                    function()
                        local filename = os.date("%s") .. ".png"
                        local parent = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h")
                        local images = parent .. "/images"
                        if vim.fn.isdirectory(images) == 0 then
                            vim.fn.mkdir(images, "p")
                        end
                        vim.fn.system("xclip -selection clipboard -t image/png -o > " .. images .. "/" .. filename)
                        local pos = vim.api.nvim_win_get_cursor(0)[2]
                        local line = vim.api.nvim_get_current_line()
                        local nline = line:sub(0, pos) .. "![](./images/" .. filename .. ")" .. line:sub(pos + 1)
                        vim.api.nvim_set_current_line(nline)
                    end,
                    "Paste image",
                },

                r = {
                    name = "REST api",
                    e = {
                        function()
                            local env = vim.fn.input({
                                prompt = "Select environment: ",
                                default = vim.fn.expand("%:h") .. "/env",
                                completion = "file",
                            })
                            require("rest-nvim").select_env(env)
                        end,
                        "Set environment",
                    },
                    l = { "<cmd>lua require('rest-nvim').last()<cr>", "Run last" },
                    p = { "<cmd>lua require('rest-nvim').run(true)<cr>", "Preview" },
                    r = { "<cmd>lua require('rest-nvim').run()<cr>", "Run at cursor" },
                },

                -- plugins/sidebar.vim
                s = {
                    name = "Sidebar",
                    c = { "<cmd>lua require('edgy').close()<CR>", "Close" },
                    g = { "<cmd>Git<CR>", "Git" },
                    n = {
                        "<cmd>Note<CR>",
                        "Notes",
                    },
                },

                S = {
                    name = "Session",
                    l = { "<cmd>SessionRestore<CR>", "Restore" },
                    s = { "<cmd>SessionSave<CR>", "Save" },
                    x = { "<cmd>SessionDelete<CR>", "Delete" },
                },

                t = {
                    name = "Terminal",
                    c = { "<cmd>VimuxPromptCommand<CR>", "Vimux commmand" },
                    l = { "<cmd>VimuxRunLastCommand<CR>", "Vimux last commmand" },
                    n = { "<cmd>call VimuxCreateNewPane<CR>", "Vimux new pane" },
                    t = { "<cmd>lua require('toggleterm').toggle(vim.v.count)<CR>", "Toggle terminal" },
                },

                T = {
                    name = "Tasks",
                    d = { "<cmd>require('neotest').run.run({strategy = 'dap'})<cr>", "Debug test" },
                    t = { "<cmd>require('neotest').run.run()<cr>", "Run test" },
                },

                u = {
                    name = "UI",
                    l = { "<cmd>lua require('lsp_lines').toggle()<cr>", "Toggle LSP Lines" },
                    s = "Toggle shade",
                    v = "Toggle drawing diagram",
                },
            }

            local v_mappings = {
                d = {
                    name = "Debug",
                    k = {
                        function()
                            require("dapui").eval()
                            require("dapui").eval()
                        end,
                        "Inspect",
                    },
                },
                f = {
                    name = "Find",
                    r = {
                        "<cmd>lua require('spectre').open_visual()<cr>",
                        "Replace",
                    },
                    w = { "<cmd>lua require('fzf-lua').grep_visual()<cr>", "Selected words" },
                },
                h = {
                    name = "Git hunks",
                    r = "Reset",
                    s = "Stage",
                },

                l = {
                    name = "LSP",
                    a = {
                        "<cmd>lua vim.lsp.buf.code_action()<cr>",
                        "Code Action",
                    },
                    f = "Format",
                },
            }

            local function to_which_key_v3(maps, key_prefix)
                local out = {}
                for k, v in pairs(maps) do
                    -- Mapping group
                    if k == "name" then
                        table.insert(out, { key_prefix, group = v })
                    -- Mappings
                    else
                        local map = key_prefix .. k
                        -- print(map)
                        if type(v) == "table" then
                            -- If a mapping
                            if vim.tbl_get(v, "name") == nil then
                                table.insert(out, { map, v[1], desc = v[2] })
                            -- If a mapping group
                            else
                                local group = to_which_key_v3(v, map)
                                for _, m in pairs(group) do
                                    table.insert(out, m)
                                end
                            end
                        elseif type(v) == "string" then
                            table.insert(out, { map, desc = v })
                        end
                    end
                end
                return out
            end

            wk.add(vim.tbl_extend("error", to_which_key_v3(n_mappings, "<leader>"), { mode = "n" }))
            wk.add(vim.tbl_extend("error", to_which_key_v3(v_mappings, "<leader>"), { mode = "v" }))
        end,
    },
}
