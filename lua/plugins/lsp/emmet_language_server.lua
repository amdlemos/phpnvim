local M = {}

M.setup = function(lspconfig)
	return lspconfig.emmet_language_server.setup({})
end

return M
