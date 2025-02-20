local lspconfig = require("lspconfig")
local bin_path = vim.fn.getcwd() .. "/node_modules/.bin/"
lspconfig.astro.setup({
	cmd = { bin_path .. "astro-ls", "--stdio" },
})
