local map = vim.keymap.set
return {
	{ "onsails/lspkind.nvim" },
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		debug = true,
		enabled = true,
		config = function()
			-- local capabilities = require("blink.cmp").get_lsp_capabilities()
			local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
			-- capabilities.positionEncoding = "utf-8"

			local on_attach = function(_, bufnr)
				local function opts(desc)
					return { buffer = bufnr, desc = "LSP " .. desc }
				end
			end

			local lspconfig = require("lspconfig")

			lspconfig.intelephense.setup({
				-- on_attach = on_attach,
				capabilities = require("blink.cmp").get_lsp_capabilities(),
				settings = {
					intelephense = {
						format = { enable = false },
					},
				},
			})

			-- lspconfig.phpactor.setup({
			-- 	root_dir = require("lspconfig").util.root_pattern("composer.json", ".git"),
			-- 	on_attach = function(client)
			-- 		client.server_capabilities.completionProvider = false
			-- 		client.server_capabilities.hoverProvider = false
			-- 		client.server_capabilities.diagnosticProvider = false
			-- 		client.server_capabilities.implementationProvider = false
			-- 		client.server_capabilities.referencesProvider = false
			-- 		client.server_capabilities.renameProvider = true
			-- 		client.server_capabilities.selectionRangeProvider = false
			-- 		client.server_capabilities.signatureHelpProvider = false
			-- 		client.server_capabilities.typeDefinitionProvider = false
			-- 		client.server_capabilities.workspaceSymbolProvider = false
			-- 		client.server_capabilities.definitionProvider = false
			-- 		client.server_capabilities.documentHighlightProvider = false
			-- 		client.server_capabilities.documentSymbolProvider = false
			-- 		client.server_capabilities.documentFormattingProvider = false
			-- 		client.server_capabilities.documentRangeFormattingProvider = false
			-- 	end,
			-- 	init_options = {
			-- 		["language_server_worse_reflection.inlay_hints.enable"] = false,
			-- 		["language_server_worse_reflection.inlay_hints.params"] = false,
			-- 		["language_server_worse_reflection.inlay_hints.types"] = false,
			-- 	},
			-- 	handlers = {
			-- 		["textDocument/publishDiagnostics"] = function() end,
			-- 	},
			--
			-- 	capabilities = capabilities,
			-- })

			-- Verifica se o arquivo psalm.xml existe
			local psalm_xml_exists = vim.fn.filereadable(vim.fn.getcwd() .. "/psalm.xml") == 1

			if psalm_xml_exists then
				lsp_capabilities = {
					workspace = {
						configuration = false,
					},
				}

				lspconfig.psalm.setup({
					cmd = {
						"vendor/bin/psalm-language-server",
						"--enable-autocomplete=false",
						"--enable-provide-definition=false",
						"--enable-provide-hover=false",
						"--enable-provide-signature-help=false",
						"--on-change-debounce-ms=500",
					},
					capabilities = lsp_capabilities,
				})
			end

			lspconfig.phan.setup({
				cmd = {
					"vendor/bin/phan",
					"-m",
					"json",
					"--no-color",
					"--no-progress-bar",
					-- "-x",
					-- "-u",
					"-S",
					"--language-server-analyze-only-on-save",
					"--language-server-disable-go-to-definition",
					"--language-server-disable-completion",
					"--language-server-disable-hover",
					"--language-server-on-stdin",
					"--allow-polyfill-parser",
				},

				capabilities = require("blink.cmp").get_lsp_capabilities(),

				settings = {
					phan = {
						files = {
							maxSize = 9000000,
						},
					},
				},
			})
		end,
	},
}
