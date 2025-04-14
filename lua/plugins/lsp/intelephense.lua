local M = {}

M.setup = function(lspconfig, capabilities)
	return lspconfig.intelephense.setup({
		-- on_attach = on_attach,
		-- capabilities = require("blink.cmp").get_lsp_capabilities(),
		capabilities = capabilities,
		settings = {
			intelephense = {
				format = { enable = false },
				folding = { enable = true },
				environment = {
					includePaths = { "/usr/lib64/php8/extensions" },
				},
			},
		},
	})
end

return M
