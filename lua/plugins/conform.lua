return {
	"stevearc/conform.nvim",
	opts = {},
	enabled = true,
	config = function()
		local conform = require("conform")
		conform.setup({
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				twig = { "ludtwig" },
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
	end,
}
