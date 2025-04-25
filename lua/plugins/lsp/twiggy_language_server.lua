local M = {}

M.setup = function(lspconfig, capabilities)
	return lspconfig.twiggy_language_server.setup({
		capabilities = capabilities,
		settings = {
			twiggy = {
				loader_paths = "/home/amdlemos/hd/vmsoft-projects/ghpro/WebSocialSaude/novosModulos/contaReceber/modals/",
				-- framework = "symfony",
				-- phpExecutable = "/usr/bin/php",
				-- symfonyConsolePath = "bin/console",
			},
		},
	})
end

return M
