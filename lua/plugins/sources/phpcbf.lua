local null_ls = require("null-ls")
local builtins = null_ls.builtins
return builtins.formatting.phpcbf.with({
	prefer_local = "vendor/bin",
	-- condition = function(utils)
	-- 	return utils.root_has_file({ ".phpcs.xml", "phpcs.xml", ".phpcs.xml.dist", "phpcs.xml.dist" })
	-- end,
})
