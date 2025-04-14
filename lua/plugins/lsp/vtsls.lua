local project_root = vim.fn.getcwd()
local bin_path = project_root .. "/node_modules/.bin/"

local project_root = vim.fn.getcwd()
local vue_plugin_path = project_root .. "/node_modules/.bin/"
local M = {}

M.setup = function(lspconfig, capabilities)
	return lspconfig.vtsls.setup({

		capabilities = capabilities,
		-- on_attach = function(client)
		-- 	-- client.server_capabilities.completionProvider = false
		-- 	-- client.server_capabilities.hoverProvider = false
		-- 	-- client.server_capabilities.diagnosticProvider = false
		-- 	-- client.server_capabilities.implementationProvider = false
		-- 	-- client.server_capabilities.referencesProvider = false
		-- 	-- client.server_capabilities.renameProvider = true
		-- 	-- client.server_capabilities.selectionRangeProvider = false
		-- 	-- client.server_capabilities.signatureHelpProvider = false
		-- 	-- client.server_capabilities.typeDefinitionProvider = false
		-- 	-- client.server_capabilities.workspaceSymbolProvider = false
		-- 	-- client.server_capabilities.definitionProvider = false
		-- 	-- client.server_capabilities.documentHighlightProvider = false
		-- 	-- client.server_capabilities.documentSymbolProvider = false
		-- 	-- client.server_capabilities.documentFormattingProvider = false
		-- 	-- client.server_capabilities.documentRangeFormattingProvider = false
		-- 	client.server_capabilities.semanticTokensProvider = nil
		-- end,

		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					-- location = vue_plugin_path .. "language-server",
					location = "",
					languages = { "vue" },
					configNamespace = "typescript",
					enableForWorkspaceTypeScriptVersions = true,
				},
			},
		},
		inlay_hints = { enabled = true },
		settings = {
			typescript = {
				preferences = {
					autoImportFileExcludePatterns = { "@radix-ui/*" },
					--[[importModuleSpecifierPreference [string] Supported values: 'shortest', 'project-relative', 'relative', 'non-relative'. Default: 'shortest']]
				},
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
		-- cmd = { bin_path .. "vtsls", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			-- "vue",
		},
		-- settings = {
		-- 	complete_function_calls = true,
		-- 	vtsls = {
		-- 		tsserver = {
		-- 			globalPlugins = {
		--
		-- 				{
		-- 					name = "@vue/typescript-plugin",
		-- 					location = vue_plugin_path .. "language-server",
		-- 					languages = { "vue" },
		-- 					configNamespace = "typescript",
		-- 					enableForWorkspaceTypeScriptVersions = true,
		-- 				},
		-- 			},
		-- 		},
		-- 		enableMoveToFileCodeAction = true,
		-- 		autoUseWorkspaceTsdk = true,
		-- 		experimental = {
		-- 			maxInlayHintLength = 30,
		-- 			completion = {
		-- 				enableServerSideFuzzyMatch = true,
		-- 			},
		-- 		},
		-- 	},
		-- 	typescript = {
		-- 		updateImportsOnFileMove = { enabled = "always" },
		-- 		suggest = {
		-- 			completeFunctionCalls = true,
		-- 		},
		-- 		inlayHints = {
		-- 			enumMemberValues = { enabled = true },
		-- 			functionLikeReturnTypes = { enabled = true },
		-- 			parameterNames = { enabled = "literals" },
		-- 			parameterTypes = { enabled = true },
		-- 			propertyDeclarationTypes = { enabled = true },
		-- 			variableTypes = { enabled = false },
		-- 		},
		-- 	},
		-- },

		-- settings = {
		-- 	tsserver = { enabled = false },
		-- 	ts_ls = { enabled = false },
		-- 	vtsls = {
		-- 		tsserver = {
		-- 			-- useSyntaxServer = false,
		-- 		},
		-- 		inlayHints = {
		-- 			includeInlayParameterNameHints = "all",
		-- 			includeInlayParameterNameHintsWhenArgumentMatchesName = true,
		-- 			includeInlayFunctionParameterTypeHints = true,
		-- 			includeInlayVariableTypeHints = true,
		-- 			includeInlayVariableTypeHintsWhenTypeMatchesName = true,
		-- 			includeInlayPropertyDeclarationTypeHints = true,
		-- 			includeInlayFunctionLikeReturnTypeHints = true,
		-- 			includeInlayEnumMemberValueHints = true,
		-- 		},
		-- 	},
		-- },
		-- customize handlers for commands
		-- handlers = {
		-- 	source_definition = function(err, locations) end,
		-- 	file_references = function(err, locations) end,
		-- 	code_action = function(err, actions) end,
		-- },
		-- automatically trigger renaming of extracted symbol
		-- refactor_auto_rename = true,
		-- refactor_move_to_file = {
		-- 	-- If dressing.nvim is installed, telescope will be used for selection prompt. Use this to customize
		-- 	-- the opts for telescope picker.
		-- 	telescope_opts = function(items, default) end,
		-- },
	})
end

return M
