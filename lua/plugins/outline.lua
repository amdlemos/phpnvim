-- Outline Configuration

require("outline").setup({
	outline_window = {
		position = "left",
	},
})

require("toggleterm").setup({
	open_mapping = "<leader>to",
	start_in_insert = false,
})

vim.keymap.set("n", "<leader>so", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
