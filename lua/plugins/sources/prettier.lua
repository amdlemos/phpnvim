local M = {}

M.setup = function(builtins)
	return builtins.formatting.prettierd.with({
		prefer_local = "node_modules/.bin",
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
			"css",
			"scss",
			"less",
			"html",
			-- "json",
			-- "jsonc",
			"yaml",
			"markdown",
			"markdown.mdx",
			"graphql",
			"handlebars",
			"svelte",
			"astro",
			"htmlangular",
			-- "twig",
		},
	})
end

return M
