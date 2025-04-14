local M = {}

M.setup = function(lspconfig)
	return lspconfig.sqlls.setup({})
end

return M
