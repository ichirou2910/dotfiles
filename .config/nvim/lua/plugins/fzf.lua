return {
    {
        "ibhagwan/fzf-lua",
        config = function()
            local fzf = require("fzf-lua")
            local img_prev_bin = vim.fn.executable("ueberzug") == 1 and { "ueberzug" }
                or vim.fn.executable("chafa") == 1 and { "chafa" }
                or vim.fn.executable("viu") == 1 and { "viu", "-b" }
                or nil

            fzf.setup({
                "default-title",
                winopts = {
                    height = 0.85,
                    width = 0.80,
                    row = 0.35,
                    col = 0.55,
                    preview = {
                        layout = "flex",
                        flip_columns = 130,
                        scrollbar = "float",
                    },
                },
                fzf_colors = function()
                    return {
                        -- Set to `-1` to use neovim fg/bg, from `man fzf`:
                        --   Default terminal foreground/background color
                        --   (or the original color of the text)
                        -- ["fg"] = { "fg", "Comment" },
                        ["bg"] = "-1",
                        ["hl"] = { "fg", { "String" } },
                        ["fg+"] = { "fg", "Normal" },
                        ["bg+"] = { "bg", { "CursorLine" } },
                        ["hl+"] = { "fg", { "String" } },
                        ["info"] = { "fg", { "WarningMsg" } },
                        -- ["prompt"] = { "fg", "SpecialKey" },
                        ["pointer"] = { "fg", "DiagnosticError" },
                        ["marker"] = { "fg", "DiagnosticError" },
                        ["spinner"] = { "fg", "Label" },
                        ["header"] = { "fg", "Comment" },
                        ["gutter"] = "-1",
                        ["scrollbar"] = { "fg", { "NightflyPeach", "WarningMsg" } },
                    }
                end,
                defaults = { formatter = "path.filename_first" },
                fzf_opts = { ["--cycle"] = "", ["--color"] = "bg:#16181a" },
                hls = function()
                    return {
                        normal = "TelescopeNormal",
                        border = "TelescopeBorder",
                        title = "TelescopePromptTitle",
                        help_normal = "TelescopeNormal",
                        help_border = "TelescopeBorder",
                        preview_normal = "TelescopeNormal",
                        preview_border = "TelescopeBorder",
                        preview_title = "TelescopePreviewTitle",
                        -- builtin preview only
                        cursor = "Cursor",
                        cursorline = "TelescopeSelection",
                        cursorlinenr = "TelescopeSelection",
                        search = "IncSearch",
                    }
                end,
                previewers = {
                    bat = { args = "--color=always --style=default" },
                    builtin = {
                        title_fnamemodify = function(s)
                            return s
                        end,
                        ueberzug_scaler = "cover",
                        extensions = {
                            ["gif"] = img_prev_bin,
                            ["png"] = img_prev_bin,
                            ["jpg"] = img_prev_bin,
                            ["jpeg"] = img_prev_bin,
                            ["svg"] = { "chafa" },
                        },
                    },
                },

                buffers = { no_action_zz = true },
                files = {
                    -- uncomment to override .gitignore
                    -- fd_opts  = "--no-ignore --color=never --type f --hidden --follow --exclude .git",
                    fzf_opts = { ["--tiebreak"] = "end" },
                },
                lsp = {
                    finder = {
                        providers = {
                            { "definitions", prefix = fzf.utils.ansi_codes.green("def ") },
                            { "declarations", prefix = fzf.utils.ansi_codes.magenta("decl") },
                            { "implementations", prefix = fzf.utils.ansi_codes.green("impl") },
                            { "typedefs", prefix = fzf.utils.ansi_codes.red("tdef") },
                            { "references", prefix = fzf.utils.ansi_codes.blue("ref ") },
                            { "incoming_calls", prefix = fzf.utils.ansi_codes.cyan("in  ") },
                            { "outgoing_calls", prefix = fzf.utils.ansi_codes.yellow("out ") },
                        },
                    },
                    code_actions = {
                        winopts = {
                            relative = "cursor",
                            row = 1,
                            col = 0,
                            height = 0.4,
                            preview = { vertical = "down:70%" },
                        },
                        previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
                        preview_pager = "delta --width=$COLUMNS --hunk-header-style='omit' --file-style='omit'",
                    },
                },
                grep = {
                    debug = false,
                    rg_glob = true,
                    rg_opts = [[--hidden --column --line-number --no-heading]]
                        .. [[ --color=always --smart-case -g "!.git" -e]],
                    -- fzf_opts = {
                    --     ["--history"] = fzf.path.join({ vim.fn.stdpath("data"), "fzf_search_hist" }),
                    -- },
                    actions = {
                        ["ctrl-r"] = { fzf.actions.grep_lgrep },
                        ["ctrl-g"] = { fzf.actions.toggle_ignore },
                    },
                },
            })
        end,
    },
}
