local M = {}

M.setup = function(lspconfig)
	return lspconfig.phpactor.setup({
		root_dir = require("lspconfig").util.root_pattern("composer.json", ".git"),
		on_attach = function(client)
			-- client.server_capabilities.completionProvider = false
			-- client.server_capabilities.hoverProvider = false
			-- client.server_capabilities.diagnosticProvider = false
			-- client.server_capabilities.implementationProvider = false
			-- client.server_capabilities.referencesProvider = false
			-- client.server_capabilities.renameProvider = true
			-- client.server_capabilities.selectionRangeProvider = false
			-- client.server_capabilities.signatureHelpProvider = false
			-- client.server_capabilities.typeDefinitionProvider = false
			-- client.server_capabilities.workspaceSymbolProvider = false
			-- client.server_capabilities.definitionProvider = false
			-- client.server_capabilities.documentHighlightProvider = false
			-- client.server_capabilities.documentSymbolProvider = false
			-- client.server_capabilities.documentFormattingProvider = false
			-- client.server_capabilities.documentRangeFormattingProvider = false
		end,
		init_options = {
			-- ["language_server_worse_reflection.inlay_hints.enable"] = false,
			-- ["language_server_worse_reflection.inlay_hints.params"] = false,
			-- ["language_server_worse_reflection.inlay_hints.types"] = false,
		},
		handlers = {
			["textDocument/publishDiagnostics"] = function() end,
		},

		capabilities = require("blink.cmp").get_lsp_capabilities(),
		-- capabilities = vim.lsp.protocol.make_client_capabilities(),
	})
end

return M
