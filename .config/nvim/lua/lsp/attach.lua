local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- local function lsp_diagnostics()
--     vim.keymap.set(
--         "n",
--         "gn",
--         "<cmd>lua vim.diagnostic.goto_next({float = false})<cr>",
--         { noremap = true, silent = true }
--     )
--     vim.keymap.set(
--         "n",
--         "gp",
--         "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>",
--         { noremap = true, silent = true }
--     )
-- end

-- This function gets run when an LSP attaches to a particular buffer.
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local bufnr = event.buf

        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Common mappings
        map("ga", require("fzf-lua").lsp_code_actions, "Code Action")
        map("gc", vim.lsp.codelens.run, "Code Lens")
        map("gd", function()
            require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
        end, "Goto Definition")
        map("gD", require("fzf-lua").lsp_typedefs, "Goto Type Definition")
        map("gi", function()
            require("fzf-lua").lsp_implementations({ jump_to_single_result = true })
        end, "Goto Implementation")
        map("<leader>lo", require("fzf-lua").lsp_document_symbols, "Document Symbols")
        map("gpd", require("goto-preview").goto_preview_definition, "Peek Definition")
        map("gpi", require("goto-preview").goto_preview_implementation, "Peek Implementation")
        map("gr", require("fzf-lua").lsp_references, "Goto Reference")
        map("gR", vim.lsp.buf.rename, "Rename Symbol")
        map("g{", require("fzf-lua").lsp_incoming_calls, "Incoming Calls")
        map("g}", require("fzf-lua").lsp_outgoing_calls, "Outgoing Calls")

        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
        map("K", function()
            local winid = require("ufo").peekFoldedLinesUnderCursor()
            if not winid then
                vim.lsp.buf.hover()
            end
        end, "Hover")

        -- Disable semantic token
        client.server_capabilities.semanticTokensProvider = nil

        -- Highlight references of the word under cursor
        if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup("UserLspHighlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("UserLspDetach", { clear = true }),
                callback = function(event2)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "UserLspHighlight", buffer = event2.buf })
                end,
            })
        end

        -- Inlay hints
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

            map("<leader>uh", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
            end, "Toggle Inlay Hints")
        end

        -- Diagnostics
        vim.diagnostic.config({
            virtual_text = false,
            float = {
                source = "always",
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.WARN] = "",
                    [vim.diagnostic.severity.INFO] = "",
                    [vim.diagnostic.severity.HINT] = "",
                },
                numhl = {
                    [vim.diagnostic.severity.ERROR] = "DiagnosticError",
                    [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
                    [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
                    [vim.diagnostic.severity.HINT] = "DiagnosticHint",
                },
            },
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })
        map("gk", function()
            vim.diagnostic.open_float({ scope = "cursor", focusable = false })
        end, "Inspect Diagnostic")

        -- Formatting
        if client.server_capabilities.documentFormattingProvider then
            map("gf", vim.lsp.buf.format, "Format")

            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format()
                end,
            })
        end

        -- Codelens
        if client.supports_method("textDocument/codeLens") then
            vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
                callback = function()
                    vim.lsp.codelens.refresh({ bufnr = 0 })
                end,
                buffer = bufnr,
            })
        end
    end,
})
