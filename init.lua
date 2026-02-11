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

-- Setup mini.pick keymaps com delay após todos os plugins
vim.defer_fn(function()
	local ok, pick = pcall(require, "mini.pick")
	if not ok or not pick or not pick.builtin then
		return
	end

	local keymap = vim.keymap.set
	local opts = { silent = true, desc = "" }

	keymap("n", "<leader>ff", pick.builtin.files, vim.tbl_extend("force", opts, { desc = "Arquivos (projeto)" }))
	keymap("n", "<leader>fa", function()
		pick.builtin.files({ source = { cwd = vim.fn.expand("~") } })
	end, vim.tbl_extend("force", opts, { desc = "Todos os arquivos" }))
	keymap("n", "<leader>fb", pick.builtin.buffers, vim.tbl_extend("force", opts, { desc = "Buffers" }))
	keymap("n", "<leader>fg", pick.builtin.grep, vim.tbl_extend("force", opts, { desc = "Grep" }))
	keymap("n", "<leader>gf", function()
		pick.builtin.files({ source = { cwd_type = "git_root" } })
	end, vim.tbl_extend("force", opts, { desc = "Git Files" }))
end, 500)

-- LSP: Configuração do Language Server Protocol
require("lsp")
