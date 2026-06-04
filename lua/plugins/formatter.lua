-- Conform (Formatter) Configuration

require("conform").setup({
	format_on_save = {
		timeout_ms = 3000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		json = { "biome" },
		html = { "prettier" },
		javascript = { "biome" },
		typescript = { "biome" },
		-- vue = { "prettier" },
		yaml = { "prettier" },
		-- blade = { "blade_formatter", "pint" },
		-- php = { "pint" },
	},
	formatters = {
		blade_formatter = {
			command = "blade-formatter",
			args = { "--stdin", "--no-php-syntax-check", "false", "--wrap-attributes", "preserve" },
			stdin = true,
		},
		pint = {
			-- Only enable pint when a pint.json is present at the project root.
			condition = function(self, ctx)
				local root = ctx.root or vim.fn.getcwd()
				if not root or root == "" then
					return false
				end
				local pint_path = root .. "/pint.json"
				local stat = vim.loop.fs_stat(pint_path)
				return stat ~= nil
			end,
		},
	},
})
