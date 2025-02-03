local M = {}

function M.setup()
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
            map("ga", vim.lsp.buf.code_action, "Code Action")
            map("gc", vim.lsp.codelens.run, "Code Lens")
            map("gpd", require("goto-preview").goto_preview_definition, "Peek Definition")
            map("gpi", require("goto-preview").goto_preview_implementation, "Peek Implementation")
            map("gR", vim.lsp.buf.rename, "Rename Symbol")
            map("g{", vim.lsp.buf.incoming_calls, "Incoming Calls")
            map("g}", vim.lsp.buf.outgoing_calls, "Outgoing Calls")

            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            map("K", function()
                local winid = require("ufo").peekFoldedLinesUnderCursor()
                if not winid then
                    vim.lsp.buf.hover()
                end
            end, "Hover")

            -- Disable semantic token
            client.server_capabilities.semanticTokensProvider = nil

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
end

return M
