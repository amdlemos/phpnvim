local project_root = vim.fn.getcwd()
local bin_path = project_root .. "/node_modules/.bin/"

local project_root = vim.fn.getcwd()
local vue_plugin_path = project_root .. "/node_modules/@vue/"

local M = {}

M.setup = function(lspconfig, capabilities)
	return lspconfig.ts_ls.setup({
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = volar_path,
					languages = { "vue" },
				},
			},
		},
		settings = {
			typescript = {
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
		-- on_attach = function(client)
		-- 	client.server_capabilities.semanticTokensProvider = nil
		-- end,
		-- -- cmd = { bin_path .. "typescript-language-server", "--stdio" },
		-- capabilities = require("blink.cmp").get_lsp_capabilities(),
		-- init_options = {
		-- 	plugins = {
		-- 		{
		-- 			name = "@vue/typescript-plugin",
		-- 			-- location = require("mason-registry").get_package("vue-language-server"):get_install_path()
		-- 			-- 	.. "/node_modules/@vue/language-server",
		-- 			location = vue_plugin_path .. "language-server",
		-- 			languages = { "vue", "javascript", "typescript" },
		-- 			-- configNamespace = "typescript",
		-- 			-- enableForWorkspaceTypeScriptVersions = true,
		-- 		},
		-- 	},
		-- },
		--
		-- handlers = {
		-- 	-- Usually gets called after another code action
		-- 	-- https://github.com/jose-elias-alvarez/typescript.nvim/issues/17
		-- 	["_typescript.rename"] = function(_, result)
		-- 		return result
		-- 	end,
		-- 	-- 'Go to definition' workaround
		-- 	-- https://github.com/holoiii/nvim/commit/73a4db74fe463f5064346ba63870557fedd134ad
		-- 	["textDocument/definition"] = function(err, result, ...)
		-- 		result = vim.islist(result) and result[1] or result
		-- 		vim.lsp.handlers["textDocument/definition"](err, result, ...)
		-- 	end,
		-- },
		-- settings = {
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
		-- 		tsserver = {
		-- 			enabled = false,
		-- 			-- useSyntaxServer = false,
		-- 		},
		-- 		vtsls = { enabled = false },
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
		-- 	enableMoveToFileCodeAction = true,
		-- 	autoUseWorkspaceTsdk = true,
		-- 	experimental = {
		-- 		maxInlayHintLength = 30,
		-- 		completion = {
		-- 			enableServerSideFuzzyMatch = true,
		-- 		},
		-- 	},
		-- },
		-- filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
	})
end

return M
