return {
    {
        "rmagatti/auto-session",
        -- enabled = false,
        config = function()
            require("auto-session").setup({
                pre_save_cmds = { "lua require('edgy').close()" },
                log_level = "error",
                auto_session_suppress_dirs = { "~/" },
                auto_session_enable_last_session = false,
                auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
                auto_session_create_enabled = false,
                auto_save_enabled = true,
                auto_restore_enabled = true,
                -- auto_session_use_git_branch = true,
                bypass_session_save_file_types = { "noice", "notify" },
            })
        end,
    },
}
