-- Vue Language Server (Volar)
-- npm install -g @vue/language-server

return {
	filetypes = { "vue" },
	init_options = {
		vue = {
			hybridMode = true,
		},
	},

	on_attach = function(client, bufnr)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}
