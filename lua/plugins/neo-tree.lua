-- Neo-Tree Configuration

require("neo-tree").setup({
	source_selector = {
		winbar = true,
		statusline = false,
	},
	window = {
		position = "right",
		mappings = {
			["[b"] = "prev_source",
			["]b"] = "next_source",
		},
		position = "left",
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { silent = true })
