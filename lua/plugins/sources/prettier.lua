local null_ls = require("null-ls")
local builtins = null_ls.builtins

return builtins.formatting.prettier.with({
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
		"json",
		"jsonc",
		"yaml",
		"markdown",
		"markdown.mdx",
		"graphql",
		"handlebars",
		"svelte",
		"astro",
		"htmlangular",
	},
})
