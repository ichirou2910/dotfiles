local navic = require("nvim-navic")

local M = {}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

function M.lsp_diagnostics()
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

    vim.keymap.set("n", "<leader>lk", function()
        vim.diagnostic.open_float({
            scope = "cursor",
            focusable = false,
        })
    end, { noremap = true, silent = true })
    vim.keymap.set(
        "n",
        "gn",
        "<cmd>lua vim.diagnostic.goto_next({float = false})<cr>",
        { noremap = true, silent = true }
    )
    vim.keymap.set(
        "n",
        "gp",
        "<cmd>lua vim.diagnostic.goto_prev({float = false})<cr>",
        { noremap = true, silent = true }
    )
end

function M.lsp_config(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
            vim.lsp.buf.hover()
        end
    end, { noremap = true, silent = true })

    -- Codelens
    if client.supports_method("textDocument/codeLens") then
        vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
            callback = function()
                vim.lsp.codelens.refresh({ bufnr = 0 })
            end,
            buffer = bufnr,
        })
    end
end

function M.lsp_formatting(client, bufnr)
    -- Formatting
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<space>lf", "<cmd>lua vim.lsp.buf.format()<CR>", { noremap = true, silent = true })

        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format()
            end,
        })
    end
end

function M.lsp_inlayHints(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end

function M.get_capabilities()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    capabilities.textDocument.completion.completionItem.documentationFormat = {
        "markdown",
        "plaintext",
    }
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
    }
    return capabilities
end

function M.lsp_attach(client, bufnr)
    M.lsp_config(client, bufnr)
    M.lsp_formatting(client, bufnr)
    M.lsp_inlayHints(client, bufnr)
    M.lsp_diagnostics()

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
end

return M
