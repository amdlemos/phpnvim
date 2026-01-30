-- Neovim Configuration
-- Estrutura modular e organizada usando vim.pack nativo

-- Core: Configurações fundamentais
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Plugins: Declaração e carregamento
require("core.plugins")

-- Plugins: Configurações individuais
-- Carregar todos os arquivos em lua/plugins/
local function load_plugins()
	local plugins_dir = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua/plugins")

	for file in vim.fs.dir(plugins_dir) do
		if file:match("%.lua$") then
			local plugin_name = file:gsub("%.lua$", "")
			pcall(require, "plugins." .. plugin_name)
		end
	end
end

load_plugins()

-- LSP: Configuração do Language Server Protocol
require("lsp")
