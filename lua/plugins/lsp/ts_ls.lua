local lspconfig = require("lspconfig")

local project_root = vim.fn.getcwd()
local vue_plugin_path = project_root .. "/node_modules/@vue/language-server/"
lspconfig.ts_ls.setup({
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
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})
