local M = {}

M.setup = function(builtins)
	return builtins.formatting.pint.with({
		prefer_local = "vendor/bin",
		condition = function(utils)
			return utils.root_has_file({ "pint.json", "src/pint.json" })
		end,
	})
end

return M
