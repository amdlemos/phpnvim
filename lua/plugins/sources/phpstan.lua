local M = {}

M.setup = function(builtins, method)
	return builtins.diagnostics.phpstan.with({
		prefer_local = "vendor/bin",
		extra_args = { "--memory-limit=1g" },
		method = method,
		condition = function(utils)
			return utils.root_has_file({ "phpstan.neon", "src/phpstan.neon" })
		end,
	})
end

return M
