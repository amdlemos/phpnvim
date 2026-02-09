-- Neo-Tree Configuration

require("neo-tree").setup({
	source_selector = {
		winbar = true,
		statusline = false,
	},
	filesystem = {
		follow_current_file = {
			enabled = true, -- 🔥 faz o reveal automático
			leave_dirs_open = true, -- mantém pastas abertas
		},
	},
	window = {
		position = "left",
		mappings = {
			["[b"] = "prev_source",
			["]b"] = "next_source",
			["h"] = "close_node",
			["l"] = "open",
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { silent = true })
