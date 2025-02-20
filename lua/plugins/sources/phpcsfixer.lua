local M = {}

M.setup = function(builtins)
	return builtins.formatting.phpcsfixer.with({
		prefer_local = "vendor/bin",
		condition = function(utils)
			return utils.root_has_file({ ".php-cs-fixer.dist.php", ".php-cs-fixer.php", ".phpmd.xml" })
		end,
	})
end

return M
