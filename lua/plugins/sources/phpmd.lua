local M = {}

M.setup = function(builtins, method)
	return builtins.diagnostics.phpmd.with({
		prefer_local = "vendor/bin",
		extra_args = { "phpmd.xml" },
		method = method,
		condition = function(utils)
			return utils.root_has_file({ "phpmd.xml" })
		end,
	})
end

return M
