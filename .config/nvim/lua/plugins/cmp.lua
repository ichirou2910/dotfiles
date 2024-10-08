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
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})

            local WIDTH = 40

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
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
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },

                formatting = {
                    format = function(_, vim_item)
                        local icon, hl = MiniIcons.get("lsp", vim_item.kind)
                        vim_item.kind = icon .. " " .. vim_item.kind
                        vim_item.kind_hl_group = hl
                        return vim_item
                    end,
                },

                sources = {
                    { name = "path" },
                    { name = "nvim_lsp", max_view_entries = 20 },
                    { name = "nvim_lsp_signature_help" },
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
