-- VTSLS (TypeScript/JavaScript Language Server)
-- TypeScript and JavaScript Language Server

return {
	on_attach = function(client, bufnr)
		client.server_capabilities.semanticTokensProvider = nil
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
	},
}
