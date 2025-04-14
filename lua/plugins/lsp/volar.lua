local vue_plugin_path = vim.fn.getcwd() .. "/node_modules/@vue/language-server/bin/"
local typescript_path = vim.fn.getcwd() .. "/node_modules"

local M = {}

M.setup = function(lspconfig, capabilities)
	return lspconfig.volar.setup({

		-- capabilities = capabilities,
		-- on_attach = function(client)
		-- 	-- client.server_capabilities.completionProvider = false
		-- 	client.server_capabilities.hoverProvider = true
		-- 	client.server_capabilities.diagnosticProvider = true
		-- 	client.server_capabilities.implementationProvider = true
		-- 	client.server_capabilities.referencesProvider = true
		-- 	-- client.server_capabilities.renameProvider = true
		-- 	-- client.server_capabilities.selectionRangeProvider = false
		-- 	client.server_capabilities.signatureHelpProvider = false
		-- 	client.server_capabilities.typeDefinitionProvider = true
		-- 	client.server_capabilities.workspaceSymbolProvider = true
		-- 	client.server_capabilities.definitionProvider = true
		-- 	client.server_capabilities.documentHighlightProvider = true
		-- 	client.server_capabilities.documentSymbolProvider = true
		-- 	-- client.server_capabilities.documentFormattingProvider = false
		-- 	-- client.server_capabilities.documentRangeFormattingProvider = false
		-- client.server_capabilities.semanticTokensProvider = nil
		-- end,
		-- cmd = { vue_plugin_path .. "vue-language-server.js", "--stdio" },
		init_options = {
			vue = {
				hybridMode = false,
			},
			-- typescript = {
			-- 	tsdk = typescript_path .. "/typescript/lib",
			-- },
			-- completion = {
			-- 	autoImport = true,
			-- 	useScaffoldSnippets = true,
			-- },
		},
		settings = {
			typescript = {
				inlayHints = {
					enumMemberValues = {
						enabled = true,
					},
					functionLikeReturnTypes = {
						enabled = true,
					},
					propertyDeclarationTypes = {
						enabled = true,
					},
					parameterTypes = {
						enabled = true,
						suppressWhenArgumentMatchesName = true,
					},
					variableTypes = {
						enabled = true,
					},
				},
			},
		},
		--
		-- filetypes = { "vue" },
	})
end

return M
