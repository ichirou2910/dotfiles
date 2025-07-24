local lspconfig = require("lspconfig")

-- local function get_capabilities()
--     local capabilities = vim.lsp.protocol.make_client_capabilities()
--
--     capabilities.textDocument.completion.completionItem.documentationFormat = {
--         "markdown",
--         "plaintext",
--     }
--     capabilities.textDocument.foldingRange = {
--         dynamicRegistration = false,
--         lineFoldingOnly = true,
--     }
--     return capabilities
-- end

-- local mason_servers = {
--     vtsls = (function()
--         local cfg = require("vtsls").lspconfig
--         -- vtsls requires node 16
--         cfg = {
--             cmd = {
--                 "/home/ichirou2910/.nvm/versions/node/v16.20.2/bin/node",
--                 vim.fn.stdpath("data") .. "/mason/bin/vtsls",
--                 "--stdio",
--             },
--         }
--         return cfg
--     end)(),
-- }
-- local mason_server_names = vim.tbl_keys(mason_servers)
--
-- require("mason").setup()
-- require("mason-lspconfig").setup({
--     ensure_installed = mason_server_names,
--     handlers = {
--         function(server_name)
--             if vim.tbl_contains(mason_server_names, server_name) then
--                 local config = mason_servers[server_name]
--                 config.capabilities = get_capabilities()
--                 lspconfig[server_name].setup(mason_servers[server_name])
--             end
--         end,
--     },
-- })

vim.lsp.enable("lua_ls")
vim.lsp.enable("vtsls")

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
        map("gR", vim.lsp.buf.rename, "Rename Symbol")
        map("g{", vim.lsp.buf.incoming_calls, "Incoming Calls")
        map("g}", vim.lsp.buf.outgoing_calls, "Outgoing Calls")

        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        map("gk", function()
            vim.diagnostic.open_float({ scope = "cursor", focusable = false })
        end, "Inspect Diagnostic")
    end,
})
