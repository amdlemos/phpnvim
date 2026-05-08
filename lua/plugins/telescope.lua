-- Telescope Configuration
-- Fuzzy finder principal: arquivos, buffers, grep, LSP, git

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local map = vim.keymap.set

telescope.setup({
	defaults = {
		prompt_prefix = "  ",
		selection_caret = " ",
		sorting_strategy = "ascending",
		path_display = {"filename_first"},
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<Esc>"] = actions.close,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

-- Extensões (pcall para não quebrar se não estiver compilado)
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")

-- Arquivos e buffers
map("n", "<leader>ff", builtin.find_files, { desc = "Arquivos (projeto)" })
map("n", "<leader>fa", function()
	builtin.find_files({ cwd = vim.fn.expand("~"), hidden = true })
end, { desc = "Todos os arquivos" })
map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Arquivos recentes" })

-- Grep / busca
map("n", "<leader>/", function()
	builtin.live_grep({
		additional_args = { "--glob", "!*.json", "--glob", "!*.csv" },
	})
end, { desc = "Live Grep" })
map("n", "<leader>fg", function()
	builtin.live_grep({
		additional_args = { "--glob", "!*.json", "--glob", "!*.csv" },
	})
end, { desc = "Live Grep" })
map("n", "<leader>fw", builtin.grep_string, { desc = "Grep word sob cursor" })

-- Git
map("n", "<leader>gf", builtin.git_files, { desc = "Git Files" })
map("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
map("n", "<leader>gl", builtin.git_commits, { desc = "Git Log (projeto)" })
map("n", "<leader>gL", builtin.git_bcommits, { desc = "Git Log (arquivo)" })

-- LSP
map("n", "<leader>ld", builtin.lsp_definitions, { desc = "Definições" })
map("n", "<leader>lr", builtin.lsp_references, { desc = "Referências" })
map("n", "<leader>li", builtin.lsp_implementations, { desc = "Implementações" })
map("n", "<leader>lt", builtin.lsp_type_definitions, { desc = "Definições de tipo" })
map("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Símbolos do documento" })
map("n", "<leader>lS", builtin.lsp_workspace_symbols, { desc = "Símbolos do workspace" })

-- Miscelânea
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>fc", builtin.commands, { desc = "Comandos" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnósticos" })
