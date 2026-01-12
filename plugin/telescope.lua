if true then
	return
end
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-frecency.nvim" },
})
require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				-- ["<C-h>"] = "which_key",
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			previewer = false,
		},
		-- live_grep = {
		--   theme = "dropdown",
		--   previewer = true,
		-- },
		buffers = {
			theme = "dropdown",
			previewer = false,
		},
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		frecency = {
			show_scores = false,
			show_unindexed = true,
			ignore_patterns = { "*.git/*", "*/tmp/*", "*/node_modules/*" },
			disable_devicons = false,
		},
	},
})

-- Carregar extensão frecency
require("telescope").load_extension("frecency")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>f", "", { desc = "Find" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Files (Telescope)" })
vim.keymap.set("n", "<leader>fr", ":Telescope frecency<CR>", { desc = "Recent Files (Frecency)", silent = true })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Old Files (Telescope)" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Live Grep (Telescope)" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers (Telescope)" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags (Telescope)" })

-- Git keymaps
vim.keymap.set("n", "<leader>g", "", { desc = "Git" })
vim.keymap.set("n", "<leader>gF", builtin.git_files, { desc = "Git Files (Telescope)" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git Status (Telescope)" })
vim.keymap.set("n", "<leader>gC", builtin.git_commits, { desc = "Git Commits (Telescope)" })
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git Branches (Telescope)" })

-- LSP keymaps com Telescope (melhores que os nativos)
vim.keymap.set("n", "<leader>l", "", { desc = "LSP" })
vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "LSP References (Telescope)" })
vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "LSP Definitions (Telescope)" })
vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, { desc = "LSP Implementations (Telescope)" })
vim.keymap.set("n", "<leader>lt", builtin.lsp_type_definitions, { desc = "LSP Type Definitions (Telescope)" })
vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "LSP Document Symbols (Telescope)" })
vim.keymap.set("n", "<leader>lw", builtin.lsp_workspace_symbols, { desc = "LSP Workspace Symbols (Telescope)" })
vim.keymap.set("n", "<leader>lD", builtin.diagnostics, { desc = "LSP Diagnostics (Telescope)" })
