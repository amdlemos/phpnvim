local lspconfig = require("lspconfig")

lspconfig.intelephense.setup({
    -- on_attach = on_attach,
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    settings = {
        intelephense = {
            format = { enable = false },
        },
    },
})
