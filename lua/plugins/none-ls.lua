return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	enabled = true,
	config = function()
		local null_ls = require("null-ls")
		local builtins = null_ls.builtins
		null_ls.setup({
			debug = false,
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
				require("plugins.sources.phpmd").setup(builtins, null_ls.methods.DIAGNOSTICS_ON_SAVE),
				require("plugins.sources.phpstan").setup(builtins, null_ls.methods.DIAGNOSTICS_ON_SAVE),
				require("plugins.sources.phpcs").setup(builtins, null_ls.methods.DIAGNOSTICS_ON_SAVE),
				require("plugins.sources.phpcsfixer").setup(builtins),
				require("plugins.sources.phpcbf").setup(builtins),
				require("plugins.sources.pint").setup(builtins),
				-- require("plugins.sources.prettier").setup(builtins),
				-- builtins.diagnostics.twigcs.with({
				-- 	-- command = "./bin/twigcs-container.sh",
				-- 	--     args = { "$FILENAME" },
				-- 	command = "docker-compose",
				-- 	args = {
				-- 		"exec",
				-- 		"-T",
				-- 		"web",
				-- 		"WebSocialSaude/vendor/bin/twigcs",
				-- 		"--",
				-- 		"$FILENAME",
				-- 	},
				-- }),
				builtins.formatting.stylua,
				builtins.formatting.xmllint,
				-- builtins.formatting.htmlbeautifier.with({
				-- 	filetypes = { "eruby", "twig" },
				-- }),
			},
		})
	end,
}
