local M = {}

M.setup = function(lspconfig, capabilities)
	lspconfig.solargraph.setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.documentSymbolProvider = false
		end,
		capabilities = capabilities,
	})
end

return M
