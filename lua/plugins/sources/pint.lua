local null_ls = require("null-ls")
local builtins = null_ls.builtins
return builtins.formatting.pint.with({
	prefer_local = "vendor/bin",
	-- condition = function(utils)
	-- 	return utils.root_has_file({ "pint.json" })
	-- end,
})
