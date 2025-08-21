if true then
	return {}
end
return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			-- Oil irá tomar conta da edição de diretórios
			default_file_explorer = true,

			-- Colunas a serem exibidas
			columns = {
				"icon",
				-- "permissions",
				"size",
				"mtime",
			},

			-- Buffer options
			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},

			-- Window options
			win_options = {
				wrap = false,
				signcolumn = "no",
				cursorcolumn = false,
				foldcolumn = "0",
				spell = false,
				list = false,
				conceallevel = 3,
				concealcursor = "nvic",
			},

			-- Opções de segurança
			delete_to_trash = true,
			skip_confirm_for_simple_edits = true,
			prompt_save_on_select_new_entry = true,
			cleanup_delay_ms = 2000,
			lsp_file_methods = {
				timeout_ms = 1000,
				autosave_changes = false,
			},

			-- Constrains para edição
			constrain_cursor = "editable",

			-- Configurações de exibição
			view_options = {
				show_hidden = false,
				is_hidden_file = function(name, bufnr)
					return vim.startswith(name, ".")
				end,
				is_always_hidden = function(name, bufnr)
					return false
				end,
				natural_order = true,
				sort = {
					{ "type", "asc" },
					{ "name", "asc" },
				},
			},

			-- Mapeamentos dentro do Oil
			keymaps = {
				["g?"] = "actions.show_help",
				["<CR>"] = "actions.select",
				["<C-s>"] = "actions.select_vsplit",
				["<C-h>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-p>"] = "actions.preview",
				["<C-c>"] = "actions.close",
				["<C-l>"] = "actions.refresh",
				["-"] = "actions.parent",
				["_"] = "actions.open_cwd",
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["gs"] = "actions.change_sort",
				["gx"] = "actions.open_external",
				["g."] = "actions.toggle_hidden",
				["g\\"] = "actions.toggle_trash",

				-- Mapeamentos personalizados
				["<leader>ff"] = {
					desc = "Find files in current dir",
					callback = function()
						require("telescope.builtin").find_files({
							cwd = require("oil").get_current_dir(),
						})
					end,
				},
				["<leader>fg"] = {
					desc = "Live grep in current dir",
					callback = function()
						require("telescope.builtin").live_grep({
							cwd = require("oil").get_current_dir(),
						})
					end,
				},
				-- Criar novo arquivo
				["<leader>nf"] = {
					desc = "Create new file",
					callback = function()
						local oil = require("oil")
						local dir = oil.get_current_dir()
						vim.ui.input({ prompt = "New file name: " }, function(input)
							if input then
								local file_path = dir .. "/" .. input
								vim.cmd("edit " .. file_path)
							end
						end)
					end,
				},
				-- Criar novo diretório
				["<leader>nd"] = {
					desc = "Create new directory",
					callback = function()
						local oil = require("oil")
						local dir = oil.get_current_dir()
						vim.ui.input({ prompt = "New directory name: " }, function(input)
							if input then
								local dir_path = dir .. "/" .. input
								vim.fn.mkdir(dir_path, "p")
								oil.open(dir_path)
							end
						end)
					end,
				},
			},

			-- Use_default_keymaps = false se quiser apenas os seus mapeamentos
			use_default_keymaps = true,

			-- Configurações de floating window
			float = {
				padding = 2,
				max_width = 0.9,
				max_height = 0.9,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
				-- Abrir floating window ao invés de substituir o buffer
				override = function(conf)
					return conf
				end,
			},

			-- Configurações de preview
			preview = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = 0.9,
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
				-- Função para decidir se deve mostrar preview
				update_on_cursor_moved = true,
			},

			-- Configurações de confirmação
			confirmation = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = 0.9,
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},

			-- Configurações de progresso
			progress = {
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = { 10, 0.9 },
				min_height = { 5, 0.1 },
				height = nil,
				border = "rounded",
				minimized_border = "none",
				win_options = {
					winblend = 0,
				},
			},

			-- SSH options
			ssh = {
				border = "rounded",
			},
		})

		-- Keymaps globais
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<leader>-", "<CMD>Oil --float<CR>", { desc = "Open parent directory in floating window" })

		-- Função para abrir Oil no diretório atual do arquivo
		vim.keymap.set("n", "<leader>o", function()
			require("oil").open(vim.fn.expand("%:p:h"))
		end, { desc = "Open current file directory" })

		-- Função para abrir Oil no root do projeto
		vim.keymap.set("n", "<leader>O", function()
			require("oil").open(vim.fn.getcwd())
		end, { desc = "Open project root directory" })
	end,
}
