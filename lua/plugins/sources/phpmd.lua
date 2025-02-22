local M = {}

M.setup = function(builtins, method)
	return builtins.diagnostics.phpmd.with({
		prefer_local = "vendor/bin",
		-- TODO: Depending on the condition you have to change the argument
		extra_args = { "phpmd.xml" },
		method = method,
		condition = function(utils)
			return utils.root_has_file({ "phpmd.xml", "rulesets.xml", "src/phpmd.xml", "src/rulesets.xml" })
		end,
	})
end

return M
