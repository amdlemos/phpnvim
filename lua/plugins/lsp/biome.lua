local lspconfig = require("lspconfig")

lspconfig.biome.setup({
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})
