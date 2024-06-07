local lsp_utils = require("lsp.utils")

require("flutter-tools").setup({
    ui = {
        -- the border type to use for all floating windows, the same options/formats
        -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
        border = "rounded",
    },
    debugger = { -- integrate with nvim dap + install dart code debugger
        enabled = false,
    },
    -- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
    flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
    widget_guides = { enabled = true },
    closing_tags = {
        highlight = "ErrorMsg", -- highlight for the closing tag
        prefix = ">", -- character to use for close tag e.g. > Widget
        enabled = true, -- set to false to disable
    },
    dev_log = {
        open_cmd = "split", -- command to use to open the log buffer
    },
    dev_tools = {
        autostart = false, -- autostart devtools server if not detected
        auto_open_browser = false, -- Automatically opens devtools in the browser
    },
    outline = {
        open_cmd = "30vnew", -- command to use to open the outline buffer
    },
    lsp = {
        on_attach = lsp_utils.lsp_attach,
        capabilities = lsp_utils.get_capabilities(), -- e.g. lsp_status capabilities
        --- OR you can specify a function to deactivate or change or control how the config is created
        -- capabilities = function(config)
        --     config.specificThingIDontWant = false
        --     return config
        -- end,
        settings = {
            showTodos = true,
            completeFunctionCalls = true,
            -- analysisExcludedFolders = {<path-to-flutter-sdk-packages>}
        },
    },
})

require("telescope").load_extension("flutter")
