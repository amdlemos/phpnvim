vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
}, { load = true })

vim.lsp.config("intelephense", {
	settings = {
		intelephense = {
			environment = {
				includePaths = {
					"vendor/laravel/framework/src",
					"vendor/laravel/ide-helper",
				},
			},
			stubs = {
				"laravel",
				"laravel-ide-helper",
			},
			format = { enable = false },
		},
	},
})

-- vim.lsp.config("phpactor", {
-- 	settings = {
-- 		phpactor = {
-- 			analysisExcludedFolders = { "/home/amdlemos/develop/" },
-- 		},
-- 	},
-- })

vim.lsp.config("dartls", {
	settings = {
		dart = {
			analysisExcludedFolders = { "/home/amdlemos/develop/" },
		},
	},
})

vim.lsp.enable({
	"intelephense",
	"phpactor",
	"html",
	"cssls",
	"jsonls",
	"emmet_language_server",
	"eslint",
	"yamlls",
	"dartls",
})
