-- Conform (Formatter) Configuration

require("conform").setup({
	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		json = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		typescript = { "biome" },
		yml = { "prettier" },
	},
	formatters = {
		blade_formatter = {
			command = "blade-formatter",
			args = { "--stdin" },
			stdin = true,
		},
	},
})
