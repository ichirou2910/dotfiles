return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            {
                "onsails/lspkind-nvim",
                config = function()
                    require("lspkind").init()
                end,
            },
        },
        config = function()
            local lspkind = require("lspkind")
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            local icons = require("core.icons")

            local WIDTH = 40

            -- local has_words_before = function()
            --     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            --     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            -- end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                performance = {
                    debounce = 150,
                },

                completion = { completeopt = "menu,menuone,noinsert" },

                window = {
                    completion = {
                        max_width = math.floor((WIDTH * 2) * (vim.o.columns / (WIDTH * 2 * 16 / 9))),
                        border = {
                            { "󱐋", "WarningMsg" },
                            { "─", "Comment" },
                            { "╮", "Comment" },
                            { "│", "Comment" },
                            { "╯", "Comment" },
                            { "─", "Comment" },
                            { "╰", "Comment" },
                            { "│", "Comment" },
                        },
                        scrollbar = false,
                    },
                    documentation = {
                        max_width = math.floor((WIDTH * 2) * (vim.o.columns / (WIDTH * 2 * 16 / 9))),
                        max_height = math.floor(WIDTH * (WIDTH / vim.o.lines)),
                        min_height = 1,
                        zindex = 100,
                        border = {
                            { "", "DiagnosticHint" },
                            { "─", "Comment" },
                            { "╮", "Comment" },
                            { "│", "Comment" },
                            { "╯", "Comment" },
                            { "─", "Comment" },
                            { "╰", "Comment" },
                            { "│", "Comment" },
                        },
                        scrollbar = false,
                    },
                },

                mapping = {
                    ["<c-n>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end),
                    ["<c-p>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end),
                    ["<Down>"] = cmp.mapping(
                        cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                        { "i" }
                    ),
                    ["<Up>"] = cmp.mapping(
                        cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                        { "i" }
                    ),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.close(),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() and cmp.get_selected_entry() then
                            cmp.confirm({
                                behavior = cmp.ConfirmBehavior.Replace,
                            })
                            return
                        end
                        if luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        -- elseif has_words_before() then
                        --     cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },

                formatting = {
                    format = lspkind.cmp_format({
                        menu = {
                            buffer = "[Buf]",
                            luasnip = "[Snip]",
                            nvim_lsp = "[LSP]",
                            path = "[Path]",
                            ["vim-dadbod-completion"] = "[DB]",
                        },
                        mode = "symbol_text",
                        maxwidth = math.floor(vim.o.columns * 0.3),
                        preset = "codicons",
                        symbol_map = {
                            Codeium = "",
                        },
                    }),
                },

                sources = {
                    { name = "path", priority_weight = 110 },
                    { name = "nvim_lsp", max_view_entries = 20, priority_weight = 100 },
                    { name = "luasnip" },
                    {
                        name = "buffer",
                        options = {
                            get_bufnrs = function()
                                local buf = vim.api.nvim_get_current_buf()
                                local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                                if byte_size > 1024 * 1024 then
                                    return {}
                                end
                                return { buf }
                            end,
                            indexing_interval = 1000,
                        },
                        max_view_entries = 5,
                        priority_weight = 70,
                    },
                    { name = "codeium" },
                },

                experimental = {
                    ghost_text = true,
                },
            })
        end,
    },
}
