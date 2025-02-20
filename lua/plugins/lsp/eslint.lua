local lspconfig = require("lspconfig")
local bin_path = vim.fn.getcwd() .. "/node_modules/.bin/"
lspconfig.eslint.setup({
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			command = "EslintFixAll",
		})
	end,
	cmd = { bin_path .. "vscode-eslint-language-server", "--stdio" },
	init_options = {
		eslint = {
			{
				codeAction = {
					disableRuleComment = {
						enable = true,
						location = "separateLine",
					},
					showDocumentation = {
						enable = true,
					},
				},
				codeActionOnSave = {
					enable = false,
					mode = "all",
				},
				experimental = {
					useFlatConfig = false,
				},
				format = true,
				nodePath = "",
				onIgnoredFiles = "off",
				problems = {
					shortenToSingleLine = false,
				},
				quiet = false,
				rulesCustomizations = {},
				run = "onType",
				useESLintClass = false,
				validate = "on",
				workingDirectory = {
					mode = "location",
				},
			},
		},
	},
})
