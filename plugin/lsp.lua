vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
}, { load = true })

vim.lsp.config("intelephense", {
	settings = {
		intelephense = {
			-- environment = {
			-- 	includePaths = {
			-- 		"vendor/laravel/framework/src",
			-- 		"vendor/laravel/ide-helper",
			-- 	},
			-- },
			-- stubs = {
			-- 	"laravel",
			-- 	"laravel-ide-helper",
			-- },
			format = { enable = false },
			phpdoc = { addPackage = false },
		},
	},
})

vim.lsp.config("phpactor", {
	on_attach = function(client, bufnr)
		-- 🔧 Capabilities (vai comentando/descomentando)
		client.server_capabilities.completionProvider = false
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.definitionProvider = false
		client.server_capabilities.referencesProvider = false
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
})

vim.lsp.config("dartls", {
	settings = {
		dart = {
			analysisExcludedFolders = { "/home/amdlemos/develop/" },
		},
	},
})

vim.lsp.enable({
	"intelephense",
	"phpactor",
	"vtsls",
	"html",
	"cssls",
	"jsonls",
	"emmet_language_server",
	"eslint",
	"yamlls",
	"dartls",
})

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Renomear Símbolo" })
