vim.lsp.enable("lua_ls")
vim.lsp.enable("vtsls")
vim.lsp.enable("roslyn_ls")

vim.lsp.config.roslyn_ls = {
    cmd = { vim.env.HOME .. "/.local/bin/Microsoft.CodeAnalysis.LanguageServer/Microsoft.CodeAnalysis.LanguageServer", "--logLevel", "Information", "--extensionLogDirectory", "/tmp/roslyn_ls/logs", "--stdio" },
    capabilities = {
        textDocument = {
            semanticTokens = vim.NIL
        },
        workspace = {
            semanticTokens = vim.NIL
        }
    }
}

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)

        if client:supports_method('textDocument/completion') then
          vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end

        local lspMap = function(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        lspMap("i", "<C-k>", vim.lsp.completion.get, "Get Completion")
        lspMap("n", "g{", vim.lsp.buf.incoming_calls, "Incoming Calls")
        lspMap("n", "g}", vim.lsp.buf.outgoing_calls, "Outgoing Calls")
    end,
})
