local null_ls = require("null-ls")
local builtins = null_ls.builtins

return builtins.diagnostics.phpstan.with({
  prefer_local = "vendor/bin",
  extra_args = { "--memory-limit=1g" },
  method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	-- condition = function(utils)
	-- 	return utils.root_has_file({ "phpstan.neon" })
	-- end,
})
