vim.pack.add({
	-- { src = "https://github.com/mfussenegger/nvim-lint" },
	{ src = "https://github.com/nvimtools/none-ls.nvim" },
}, { load = true })
local null_ls = require("null-ls")

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
		null_ls.builtins.diagnostics.phpcs.with({
			prefer_local = "vendor/bin",
		}),
		null_ls.builtins.diagnostics.phpmd.with({
			prefer_local = "vendor/bin",
			extra_args = { "phpmd.xml", "--exclude", "tests/*,vendor/*,.ddev/*,app/Actions/Fortify/*,_ide_helper.php" },
			method = method,
			condition = function(utils)
				return utils.root_has_file({ "phpmd.xml", "rulesets.xml", "src/phpmd.xml", "src/rulesets.xml" })
			end,
		}),
		null_ls.builtins.formatting.phpcbf.with({
			prefer_local = "vendor/bin",
			condition = function(utils)
				return utils.root_has_file({
					".phpcs.xml",
					"phpcs.xml",
					".phpcs.xml.dist",
					"phpcs.xml.dist",
					"src/.phpcs.xml",
					"src/phpcs.xml",
					"src/.phpcs.xml.dist",
					"src/phpcs.xml.dist",
				})
			end,
		}),
		null_ls.builtins.formatting.pint.with({
			prefer_local = "vendor/bin",
			condition = function(utils)
				return utils.root_has_file({ "pint.json" })
			end,
		}),

		null_ls.builtins.diagnostics.phpstan.with({
			prefer_local = "vendor/bin",
			condition = function(utils)
				return utils.root_has_file({ "phpstan.neon" })
			end,
		}),
	},
})
