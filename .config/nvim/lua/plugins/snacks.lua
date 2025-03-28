return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            bufdelete = { enabled = true },
            explorer = { enabled = true },
            indent = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = {
                enabled = true,
                left = { "mark", "sign" }, -- priority of signs on the left (high to low)
                right = { "fold", "git" }, -- priority of signs on the right (high to low)
                folds = {
                    open = false, -- show open fold icons
                    git_hl = false, -- use Git Signs hl for fold icons
                },
                git = {
                    -- patterns to match Git signs
                    patterns = { "GitSign", "MiniDiffSign" },
                },
                refresh = 50, -- refresh at most every 50ms
            },
            terminal = { enabled = true },
        },
        -- stylua: ignore
        keys = {
            -- Search
            { "<leader>;", function() Snacks.picker.commands() end, desc = "Commands" },
            { "<leader>a", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fa", function() Snacks.picker.grep() end, desc = "Text" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fn", function() Snacks.picker.notifications() end, desc = "notifications" },
            { "<leader>fR", function() Snacks.picker.recent() end, desc = "Recent" },
            { "<leader>fs", function() Snacks.picker.search_history() end, desc = "Search History" },
            { "<leader>fw", function() Snacks.picker.grep_word() end, desc = "Word" },
            -- Git
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Log" },
            { "<leader>gL", function() Snacks.picker.git_log_file() end, desc = "File Log" },
            -- LSP
            { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
            { "gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto Type Definition" },
            { "<leader>lo", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
            -- Terminal
            { "<leader>tt", function() Snacks.terminal.toggle() end, desc = "Toggle Terminal" },
            -- Buffer
            { "<leader>q", function() Snacks.bufdelete.delete() end, desc = "Delete Buffer" },
            { "<leader>Q", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
        }
,
    },
}
