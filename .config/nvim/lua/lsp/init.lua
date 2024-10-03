local lspconfig = require("lspconfig")

local function get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities()

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

-- servers with default config
local default_servers = { "html", "cssls", "gdscript" }
for _, s in pairs(default_servers) do
    lspconfig[s].setup({
        capabilities = get_capabilities(),
        debounce_text_changes = 150,
    })
end

-- servers handled by mason
local mason_servers = {
    lua_ls = {
        flags = { debounce_text_changes = 150 },
        single_file_support = true,
        settings = {
            Lua = {
                format = {
                    enable = false,
                },
            },
        },
    },
    phpactor = {},
}
local mason_server_names = vim.tbl_keys(mason_servers)

require("mason").setup()
require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            if vim.tbl_contains(mason_server_names, server_name) then
                local config = mason_servers[server_name]
                config.capabilities = get_capabilities()
                lspconfig[server_name].setup(mason_servers[server_name])
            end
        end,
    },
})

-- Extra LSP not managed by lspconfig
require("lsp.extras").setup(get_capabilities())
require("lsp.null-ls").setup()

-- Setup LspAttach event
require("lsp.attach")
