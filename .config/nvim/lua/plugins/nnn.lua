return {
    {
        "luukvbaal/nnn.nvim",
        enabled = false,
        config = function()
            require("nnn").setup({
                explorer = {
                    cmd = "nnn -A", -- command overrride (-F1 flag is implied, -a flag is invalid!)
                    width = 24, -- width of the vertical split
                    side = "topleft", -- or "botright", location of the explorer window
                    session = "", -- or "global" / "local" / "shared"
                    tabs = true, -- seperate nnn instance per tab
                },
                picker = {
                    cmd = "nnn -A", -- command override (-p flag is implied)
                    style = {
                        width = 0.5, -- percentage relative to terminal size when < 1, absolute otherwise
                        height = 0.8, -- ^
                        xoffset = 0.5, -- ^
                        yoffset = 0.5, -- ^
                    },
                    session = "", -- or "global" / "local" / "shared"
                },
                auto_open = {
                    setup = nil, -- or "explorer" / "picker", auto open on setup function
                    tabpage = nil, -- or "explorer" / "picker", auto open when opening new tabpage
                    empty = false, -- only auto open on empty buffer
                    ft_ignore = { -- dont auto open for these filetypes
                        "gitcommit",
                    },
                },
                auto_close = false, -- close tabpage/nvim when nnn is last window
                replace_netrw = nil, -- or "explorer" / "picker"
                mappings = {}, -- table containing mappings, see below
                windownav = { -- window movement mappings to navigate out of nnn
                    left = "<C-w>h",
                    right = "<C-w>l",
                    next = "<C-w>w",
                    prev = "<C-w>W",
                },
                buflisted = false, -- whether or not nnn buffers show up in the bufferlist
                quitcd = "cd", -- or "cd" / "lcd", command to run if quitcd file is found
                offset = false, -- whether or not to write position offset to tmpfile(for use in preview-tui)
            })
        end,
    },
}
