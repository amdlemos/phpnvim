local lspconfig = require("lspconfig")
local project_root = vim.fn.getcwd()
local bin_path = project_root .. "/node_modules/.bin/"
require("lspconfig").vtsls.setup({
	on_attach = function(client)
		-- client.server_capabilities.completionProvider = false
		-- client.server_capabilities.hoverProvider = false
		-- client.server_capabilities.diagnosticProvider = false
		-- client.server_capabilities.implementationProvider = false
		-- client.server_capabilities.referencesProvider = false
		-- client.server_capabilities.renameProvider = true
		-- client.server_capabilities.selectionRangeProvider = false
		client.server_capabilities.signatureHelpProvider = false
		-- client.server_capabilities.typeDefinitionProvider = false
		-- client.server_capabilities.workspaceSymbolProvider = false
		-- client.server_capabilities.definitionProvider = false
		client.server_capabilities.documentHighlightProvider = false
		-- client.server_capabilities.documentSymbolProvider = false
		-- client.server_capabilities.documentFormattingProvider = false
		-- client.server_capabilities.documentRangeFormattingProvider = false
		client.server_capabilities.semanticTokensProvider = false
	end,
	cmd = { bin_path .. "vtsls", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
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
	-- capabilities = require("blink.cmp").get_lsp_capabilities(),
})
