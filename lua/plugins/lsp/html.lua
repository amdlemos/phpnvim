local M = {}

local bin_path = vim.fn.getcwd() .. "/node_modules/.bin/"

M.setup = function(lspconfig)
	return lspconfig.html.setup({
		cmd = { bin_path .. "vscode-html-language-server", "--stdio" },
	})
end

return M
