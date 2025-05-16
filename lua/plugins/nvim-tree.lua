-- return {
-- 	"nvim-tree/nvim-tree.lua",
-- 	version = "*",
-- 	lazy = false,
-- 	dependencies = {
-- 		"nvim-tree/nvim-web-devicons",
-- 	},
-- 	config = function()
-- 		-- Configuração básica do nvim-tree
-- 		require("nvim-tree").setup({
-- 			sort = {
-- 				sorter = "case_sensitive",
-- 			},
-- 			view = {
-- 				width = 30,
-- 			},
-- 			renderer = {
-- 				group_empty = true,
-- 			},
-- 			filters = {
-- 				dotfiles = false,
-- 			},
-- 			actions = {
-- 				open_file = {
-- 					resize_window = true, -- Ajuda a redimensionar janelas corretamente ao abrir arquivos
-- 				},
-- 			},
-- 			on_attach = function(bufnr)
-- 				local api = require("nvim-tree.api")
--
-- 				-- Função para criar mapeamentos mais facilmente
-- 				local function opts(desc)
-- 					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
-- 				end
--
-- 				-- Mapeamentos padrão do nvim-tree que podem ser úteis
-- 				vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
-- 				vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
-- 				vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
-- 				vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
-- 				vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
-- 				vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
-- 				vim.keymap.set("n", "a", api.fs.create, opts("Create"))
-- 				vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
-- 				vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
-- 				vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
-- 				vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
-- 				vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
-- 				vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
-- 				vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
-- 				vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
-- 				vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
-- 			end,
-- 		})
--
-- 		-- Auto comandos para garantir que o redimensionamento funcione bem com dap-ui
-- 		vim.api.nvim_create_autocmd("User", {
-- 			pattern = "NvimTreeClose",
-- 			callback = function()
-- 				vim.cmd("wincmd =") -- Equilibrar janelas após o fechamento do NvimTree
-- 			end,
-- 		})
--
-- 		vim.api.nvim_create_autocmd("User", {
-- 			pattern = "NvimTreeOpen",
-- 			callback = function()
-- 				vim.cmd("wincmd =") -- Equilibrar janelas após a abertura do NvimTree
-- 			end,
-- 		})
-- 	end,
-- 	keys = {
-- 		{
-- 			"<leader>e",
-- 			function()
-- 				require("nvim-tree.api").tree.toggle()
-- 				-- Equilibrar janelas após o toggle para garantir layout correto
-- 				vim.defer_fn(function()
-- 					vim.cmd("wincmd =")
-- 				end, 50)
-- 			end,
-- 			desc = "Toggle NvimTree Explorer",
-- 		},
-- 	},
-- }

-- Arquivo de configuração para nvim-tree utilizando o novo gerenciador de janelas
-- Coloque em: ~/.config/nvim/lua/plugins/nvim-tree.lua

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		-- Carrega o gerenciador de janelas
		local window_manager = require("config.window_manager")

		-- Configura o nvim-tree através do gerenciador
		window_manager.setup_nvim_tree()
	end,
}
