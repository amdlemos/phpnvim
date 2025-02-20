return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	enabled = true,
	config = function()
		local null_ls = require("null-ls")
		local builtins = null_ls.builtins
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			debug = true,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								async = true,
							})
						end,
					})
				end
			end,
			sources = {
				require("plugins.sources.phpcs"),
				require("plugins.sources.phpmd"),
				require("plugins.sources.phpstan"),
				require("plugins.sources.phpcsfixer"),
				require("plugins.sources.prettier"),

				builtins.formatting.pint.with({
					prefer_local = "vendor/bin",
				}),

				builtins.formatting.phpcbf.with({
					prefer_local = "vendor/bin",
				}),
				builtins.formatting.stylua,
				builtins.formatting.xmllint,
			},
		})
	end,
}
