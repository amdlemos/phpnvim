local M = {}

M.setup = function(lspconfig)
	local psalm_xml_exists = vim.fn.filereadable(vim.fn.getcwd() .. "/psalm.xml") == 1
	if psalm_xml_exists then
		local lsp_capabilities = {
			workspace = {
				configuration = false,
			},
		}

		return lspconfig.psalm.setup({
			cmd = {
				"vendor/bin/psalm-language-server",
				"--enable-autocomplete=false",
				"--enable-provide-definition=false",
				"--enable-provide-hover=false",
				"--enable-provide-signature-help=false",
				"--on-change-debounce-ms=500",
			},
			capabilities = lsp_capabilities,
		})
	end
end

return M
