return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	enabled = true,
	config = function()
		local null_ls = require("null-ls")
		local builtins = null_ls.builtins
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								async = false,
							})
						end,
					})
				end
			end,
			sources = {

				--phpcs
				builtins.diagnostics.phpcs.with({
					prefer_local = "vendor/bin",
					method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
					condition = function(utils)
						return utils.root_has_file("phpcs.xml")
					end,
				}),

				-- phpmd
				builtins.diagnostics.phpmd.with({
					prefer_local = "vendor/bin",
					extra_args = { "phpmd.xml" },
					method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
					condition = function(utils)
						return utils.root_has_file("phpmd.xml")
					end,
				}),

				-- phpstan
				builtins.diagnostics.phpstan.with({
					prefer_local = "vendor/bin",
					extra_args = { "--memory-limit=1g" },
					method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
				}),

				-- php-cs-fixer
				builtins.formatting.phpcsfixer.with({
					prefer_local = "vendor/bin",
				}),

				builtins.formatting.stylua,
				builtins.formatting.xmllint,
			},
		})
	end,
}
