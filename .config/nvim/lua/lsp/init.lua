local lspconfig = require("lspconfig")
local capabilities = require("lsp.utils").get_capabilities()

-- servers with default config
local default_servers = { "html", "cssls", "gdscript" }
for _, s in pairs(default_servers) do
    lspconfig[s].setup({
        capabilities = capabilities,
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
    vtsls = (function()
        local cfg = require("vtsls").lspconfig
        -- vtsls requires node 16
        cfg = {
            cmd = {
                "/usr/share/nvm/nvm-exec",
                vim.fn.stdpath("data") .. "/mason/bin/vtsls",
                "--stdio",
            },
            cmd_env = {
                NODE_VERSION = "v16.20.2",
            },
        }
        return cfg
    end)(),
    phpactor = {},
}
local mason_server_names = vim.tbl_keys(mason_servers)

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = mason_server_names,
    handlers = {
        function(server_name)
            if vim.tbl_contains(mason_server_names, server_name) then
                local config = mason_servers[server_name]
                config.capabilities = capabilities
                lspconfig[server_name].setup(mason_servers[server_name])
            end
        end,
    },
})

-- Extra LSP not managed by lspconfig
require("lsp.extras").setup()
require("lsp.null-ls").setup()

-- Setup LspAttach event
require("lsp.attach").setup()
