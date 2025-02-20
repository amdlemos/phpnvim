local null_ls = require("null-ls")
local builtins = null_ls.builtins

return builtins.diagnostics.phpmd.with({
	prefer_local = "vendor/bin",
	extra_args = { "phpmd.xml" },
	method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
	-- condition = function(utils)
	-- 	return utils.root_has_file({ "phpmd.xml" })
	-- end,
})
