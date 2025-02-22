local vue_plugin_path = vim.fn.getcwd() .. "/node_modules/.bin/"
local typescript_path = vim.fn.getcwd() .. "/node_modules"

local M = {}

M.setup = function(lspconfig, capabilities)
	return lspconfig.volar.setup({
		on_attach = function(client)
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
			-- client.server_capabilities.semanticTokensProvider = false
		end,
		cmd = { vue_plugin_path .. "vue-language-server", "--stdio" },
		capabilities = capabilities,
		init_options = {
			vue = {
				hybridMode = true,
			},
			typescript = {
				tsdk = typescript_path .. "/typescript/lib", -- Certifique-se de que o TypeScript do projeto está sendo usado
			},
			completion = {
				autoImport = true,
				useScaffoldSnippets = true,
			},
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

		filetypes = { "typescript", "javascript", "vue", "json" },
	})
end

return M
