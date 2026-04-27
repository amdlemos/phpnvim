-- VTSLS (TypeScript/JavaScript Language Server)
-- TypeScript and JavaScript Language Server
-- Vue: requer @vue/typescript-plugin no node_modules do projeto

return {
	on_attach = function(client, bufnr)
		client.server_capabilities.semanticTokensProvider = nil
		client.server_capabilities.documentFormattingProvider = false
	end,
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},
	settings = {
		vtsls = {
			tsserver = {
				globalPlugins = {
					{
						name = "@vue/typescript-plugin",
						location = "",
						languages = { "vue" },
						configNamespace = "typescript",
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
		},
	},
}
