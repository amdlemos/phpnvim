-- Conform (Formatter) Configuration

require("conform").setup({
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		json = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		typescript = { "biome" },
		-- vue = { "prettier" },
		yaml = { "prettier" },
		blade = { "blade_formatter" },
		php = { "php_cs_fixer" },
	},
	formatters = {
		blade_formatter = {
			command = "blade-formatter",
			args = { "--stdin" },
			stdin = true,
		},
	},
})
