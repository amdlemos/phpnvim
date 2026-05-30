local null_ls = require("null-ls")

null_ls.setup({
	temp_dir = "/tmp",
	sources = {
		null_ls.builtins.diagnostics.phpstan.with({
			prefer_local = "vendor/bin",
			extra_args = { "--memory-limit=1g" },
			condition = function(utils)
				return utils.root_has_file({ "phpstan.neon", "phpstan.neon.dist" })
			end,
			method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
			temp_dir = "/tmp",
		}),
	},
})
