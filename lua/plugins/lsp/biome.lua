local M = {}

M.setup = function(lspconfig, capabilities)
	return lspconfig.biome.setup({
		capabilities = capabilities,
		filetypes = {
			"astro",
			"css",
			"graphql",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"svelte",
			"typescript",
			"typescript.tsx",
			"typescriptreact",
			"vue",
		},
	})
end

return M
