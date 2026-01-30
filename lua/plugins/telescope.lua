-- Telescope Configuration

local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
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
		buffers = {
			theme = "dropdown",
			previewer = false,
		},
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
telescope.load_extension("frecency")

-- Keymaps
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

-- LSP keymaps com Telescope
vim.keymap.set("n", "<leader>l", "", { desc = "LSP" })
vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "LSP References (Telescope)" })
vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "LSP Definitions (Telescope)" })
vim.keymap.set("n", "<leader>li", builtin.lsp_implementations, { desc = "LSP Implementations (Telescope)" })
vim.keymap.set("n", "<leader>lt", builtin.lsp_type_definitions, { desc = "LSP Type Definitions (Telescope)" })
vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "LSP Document Symbols (Telescope)" })
vim.keymap.set("n", "<leader>lw", builtin.lsp_workspace_symbols, { desc = "LSP Workspace Symbols (Telescope)" })
vim.keymap.set("n", "<leader>lD", builtin.diagnostics, { desc = "LSP Diagnostics (Telescope)" })
