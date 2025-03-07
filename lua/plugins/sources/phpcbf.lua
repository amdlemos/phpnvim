local M = {}

M.setup = function(builtins)
	return builtins.formatting.phpcbf.with({
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
	})
end

return M
