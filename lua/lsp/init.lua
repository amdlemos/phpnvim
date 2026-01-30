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
	"phpactor",
	"vtsls",
	"html",
	"cssls",
	"jsonls",
	"emmet_language_server",
	"eslint",
	"yamlls",
	"dartls",
	"tailwindcss",
}

-- Carregar e configurar cada servidor
for _, server_name in ipairs(enabled_servers) do
	local ok, server_config = pcall(require, "lsp.servers." .. server_name)
	if ok and server_config then
		local config = {
			capabilities = capabilities,
		}

		-- Se o servidor tem on_attach próprio, usar ele, senão usar o padrão
		if server_config.on_attach then
			config.on_attach = server_config.on_attach
			-- Remover on_attach do server_config antes de mesclar
			local server_config_copy = vim.deepcopy(server_config)
			server_config_copy.on_attach = nil
			config = vim.tbl_deep_extend("force", config, server_config_copy)
		else
			config.on_attach = on_attach
			config = vim.tbl_deep_extend("force", config, server_config)
		end

		-- Configurar o servidor usando vim.lsp.config (API nativa)
		vim.lsp.config(server_name, config)
	else
		-- Se não há arquivo específico, usar configuração padrão
		vim.lsp.config(server_name, {
			capabilities = capabilities,
			on_attach = on_attach,
		})
	end
end

-- Habilitar servidores
vim.lsp.enable(enabled_servers)
