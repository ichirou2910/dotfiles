if not vim.g.vscode then
    vim.g.mapleader = " "

    -- Install Lazy.nvim if not on machine
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        })
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        spec = {
            { import = "plugins" },
        },
        -- defaults = { lazy = true },
        performance = {
            cache = {
                enabled = true,
                -- disable_events = {},
            },
            checker = { enabled = true },
            rtp = {
                disabled_plugins = {
                    "gzip",
                    -- "matchit",
                    -- "matchparen",
                    "netrwPlugin",
                    "rplugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
                },
            },
        },
    })

    local modules = {
        "core.options",
        "core.mappings",
        "core.autocmds",
        "core.clipboard",
    }

    for _, module in ipairs(modules) do
        local ok, err = pcall(require, module)
        if not ok then
            error("Error loading " .. module .. "\n\n" .. err)
        end
    end
else
    local ok, err = pcall(require, "vscode")
    if not ok then
        error("Error loading " .. "vscode" .. "\n\n" .. err)
    end
end
