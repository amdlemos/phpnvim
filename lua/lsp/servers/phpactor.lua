-- PhpActor Language Server
-- PHP Language Server

local default_on_attach = require("lsp.on_attach")

return {
	on_attach = function(client, bufnr)
		-- Chamar on_attach padrão primeiro
		default_on_attach(client, bufnr)

		-- Desabilitar capabilities específicas do phpactor
		client.server_capabilities.completionProvider = false
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.definitionProvider = false
		client.server_capabilities.referencesProvider = true
		client.server_capabilities.typeDefinitionProvider = false
		-- client.server_capabilities.diagnosticProvider = false
		-- client.server_capabilities.implementationProvider = false
		-- client.server_capabilities.renameProvider = true
		-- client.server_capabilities.selectionRangeProvider = false
		-- client.server_capabilities.signatureHelpProvider = false
		-- client.server_capabilities.workspaceSymbolProvider = false
		-- client.server_capabilities.documentHighlightProvider = false
		-- client.server_capabilities.documentSymbolProvider = false
		-- client.server_capabilities.documentFormattingProvider = false
		-- client.server_capabilities.documentRangeFormattingProvider = false
	end,
	init_options = {
		["language_server_worse_reflection.inlay_hints.enable"] = false,
		["language_server_worse_reflection.inlay_hints.params"] = false,
		["language_server_worse_reflection.inlay_hints.types"] = false,
	},
	handlers = {
		-- Desliga diagnósticos do phpactor
		["textDocument/publishDiagnostics"] = function() end,
	},
}
