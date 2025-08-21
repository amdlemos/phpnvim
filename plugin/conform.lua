local conform = require("conform")
conform.setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		twig = { "ludtwig" },
		lua = { "stylua" },
		json = { "prettier" },
		xml = { "prettier" },
		html = { "prettier" },
		javascript = { "biome" },
		typescript = { "biome" },
	},
	formatters = {
		ludtwig = {
			inherit = false,
			command = "ludtwig",
			args = { "-f", "$FILENAME" },
			stdin = false,
		},
	},
})
