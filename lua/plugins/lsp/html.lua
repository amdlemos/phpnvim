local lspconfig = require("lspconfig")
local bin_path = vim.fn.getcwd() .. "/node_modules/.bin/"
lspconfig.html.setup({
	cmd = { bin_path .. "vscode-html-language-server", "--stdio" },
})

lspconfig.cssls.setup({
	cmd = { bin_path .. "vscode-css-language-server", "--stdio" },
})
