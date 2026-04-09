-- LSP Configuration
-- Configuração centralizada do Language Server Protocol
-- Usando vim.lsp.config (API nativa do Neovim 0.11+)

-- Carregar keymaps globais primeiro
require("lsp.keymaps")

-- Carregar capabilities compartilhadas
local capabilities = require("lsp.capabilities")

-- Carregar on_attach centralizado
local on_attach = require("lsp.on_attach")

-- Lista de servidores habilitados
local enabled_servers = {
	"intelephense",
    "copilot_language_server",
	-- "phpactor",
	-- "vtsls",
	"html",
	"cssls",
	"jsonls",
	"emmet_language_server",
	"eslint",
	"yamlls",
	"dartls",
	"tailwindcss",
	-- "vue_ls",
}

-- Carregar e configurar cada servidor
for _, server_name in ipairs(enabled_servers) do
	local ok, server_config = pcall(require, "lsp.servers." .. server_name)
	local config = {
		capabilities = capabilities,
		on_attach = on_attach,
	}

	if ok and server_config then
		config = vim.tbl_deep_extend("force", config, server_config)
	end

	-- Configurar e habilitar o servidor usando a API nativa do Neovim 0.11+
	-- Isso substitui o antigo lspconfig[server].setup()
	vim.lsp.config(server_name, config)
	vim.lsp.enable(server_name)
end
