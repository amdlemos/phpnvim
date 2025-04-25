local M = {}

M.setup = function(lspconfig)
	return lspconfig.emmet_language_server.setup({
		filetypes = {
			"css",
			"eruby",
			"html",
			"htmldjango",
			"javascriptreact",
			"less",
			"pug",
			"sass",
			"scss",
			"typescriptreact",
			"htmlangular",
      "twig",
		},
	})
end

return M
