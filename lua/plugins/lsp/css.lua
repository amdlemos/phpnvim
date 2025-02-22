local M = {}

local bin_path = vim.fn.getcwd() .. "/node_modules/.bin/"

M.setup = function(lspconfig)
	lspconfig.cssls.setup({
		cmd = { bin_path .. "vscode-css-language-server", "--stdio" },
	})
end

return M
