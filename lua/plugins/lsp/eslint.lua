-- local bin_path = vim.fn.getcwd() .. "/node_modules/.bin/"

local M = {}

M.setup = function(lspconfig)
	return lspconfig.eslint.setup({
		on_attach = function(client, bufnr)
			client.server_capabilities.completionProvider = false
			client.server_capabilities.hoverProvider = false
			client.server_capabilities.diagnosticProvider = true
			client.server_capabilities.implementationProvider = false
			client.server_capabilities.referencesProvider = false
			client.server_capabilities.renameProvider = true
			client.server_capabilities.selectionRangeProvider = false
			client.server_capabilities.signatureHelpProvider = false
			client.server_capabilities.typeDefinitionProvider = false
			client.server_capabilities.workspaceSymbolProvider = false
			client.server_capabilities.definitionProvider = false
			client.server_capabilities.documentHighlightProvider = false
			client.server_capabilities.documentSymbolProvider = false
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			-- vim.api.nvim_create_autocmd("BufWritePre", {
			-- 	buffer = bufnr,
			-- 	command = "EslintFixAll",
			-- })
		end,
		-- cmd = { bin_path .. "vscode-eslint-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
			"vue",
			"svelte",
			"astro",
			"json",
		},

		capabilities = require("blink.cmp").get_lsp_capabilities(),
		-- init_options = {
		-- 	eslint = {
		-- 		{
		-- 			codeAction = {
		-- 				disableRuleComment = {
		-- 					enable = true,
		-- 					location = "separateLine",
		-- 				},
		-- 				showDocumentation = {
		-- 					enable = true,
		-- 				},
		-- 			},
		-- 			codeActionOnSave = {
		-- 				enable = false,
		-- 				mode = "all",
		-- 			},
		-- 			experimental = {
		-- 				useFlatConfig = false,
		-- 			},
		-- 			format = false,
		-- 			nodePath = "",
		-- 			onIgnoredFiles = "off",
		-- 			problems = {
		-- 				shortenToSingleLine = false,
		-- 			},
		-- 			quiet = false,
		-- 			rulesCustomizations = {},
		-- 			run = "onType",
		-- 			useESLintClass = false,
		-- 			validate = "on",
		-- 			workingDirectory = {
		-- 				mode = "location",
		-- 			},
		-- 		},
		-- 	},
		-- },
	})
end

return M
