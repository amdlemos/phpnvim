local M = {}

M.setup = function(builtins, capabilities)
	return builtins.sorbet.setup({
		on_attach = function(client, bufnr)
			-- client.server_capabilities.completionProvider = true
			-- client.server_capabilities.hoverProvider = false
			-- client.server_capabilities.diagnosticProvider = true
			-- client.server_capabilities.implementationProvider = false
			-- client.server_capabilities.referencesProvider = false
			-- client.server_capabilities.renameProvider = true
			-- client.server_capabilities.selectionRangeProvider = false
			-- client.server_capabilities.signatureHelpProvider = false
			-- client.server_capabilities.typeDefinitionProvider = false
			-- client.server_capabilities.workspaceSymbolProvider = false
			-- client.server_capabilities.definitionProvider = false
			-- client.server_capabilities.documentHighlightProvider = false
			-- client.server_capabilities.documentSymbolProvider = true
			-- client.server_capabilities.documentFormattingProvider = false
			-- client.server_capabilities.documentRangeFormattingProvider = false
		end,
		capabilities = capabilities,
	})
end

return M
