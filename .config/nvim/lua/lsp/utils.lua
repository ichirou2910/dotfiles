local M = {}

function M.get_capabilities()
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

return M
