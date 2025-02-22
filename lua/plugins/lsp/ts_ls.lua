local project_root = vim.fn.getcwd()
local vue_plugin_path = project_root .. "/node_modules/.bin/"

local M = {}

M.setup = function(lspconfig, capabilities)
	return lspconfig.ts_ls.setup({
		on_attach = function() end,
		cmd = { vue_plugin_path .. "typescript-language-server", "--stdio" },
		capabilities = require("blink.cmp").get_lsp_capabilities(),
		init_options = {
			plugins = { -- I think this was my breakthrough that made it work
				{
					name = "@vue/typescript-plugin",
					location = vue_plugin_path .. "language-server",
					languages = { "vue" },
				},
			},
			settings = {
				typescript = {
					tsserver = {
						useSyntaxServer = false,
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
		},
		filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
	})
end

return M
