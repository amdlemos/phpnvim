-- if true then
-- 	return
-- end
vim.pack.add({
	{ src = "https://github.com/stevearc/conform.nvim" },
}, { load = true })

require("conform").setup({
	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		-- twig = { "ludtwig" },
		 lua = { "stylua" },
		-- blade = { "blade_formatter" },
		json = { "prettier" },
		-- xml = { "prettier" },
		html = { "prettier" },
		javascript = { "prettier" },
		typescript = { "biome" },
		yml = { "prettier" },
        -- php = { "php_cs_fixer" }
	},
	formatters = {
		-- ludtwig = {
		-- 	inherit = false,
		-- 	command = "ludtwig",
		-- 	args = { "-f", "$FILENAME" },
		-- 	stdin = false,
		-- },
		blade_formatter = {
			command = "blade-formatter",
			args = { "--stdin" }, -- Adjust args as needed
			stdin = true,
		},
	},
})
