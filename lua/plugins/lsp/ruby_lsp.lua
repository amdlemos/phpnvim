local M = {}

M.setup = function(lspconfig, capabilities)
	return lspconfig.ruby_lsp.setup({
		on_attach = function(client, bufnr)
		end,
		capabilities = capabilities,
	})
end

return M
