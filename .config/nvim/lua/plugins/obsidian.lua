return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        event = {
            -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
            -- refer to `:h file-pattern` for more examples
            "BufReadPre /media"
                .. vim.fn.expand("~")
                .. "/Obsidian/*.md",
            "BufNewFile /media" .. vim.fn.expand("~") .. "/Obsidian/*.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",

            -- see below for full list of optional dependencies 👇
            "hrsh7th/nvim-cmp",
            "ibhagwan/fzf-lua",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            workspaces = {
                {
                    name = "Ichirou's Vault",
                    path = "~/Obsidian/Ichirou's Vault",
                },
            },

            -- see below for full list of options 👇
            ui = {
                -- We'll be using markview.nvim for this
                enable = false,
            },
        },
    },
}
