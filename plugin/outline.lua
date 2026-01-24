vim.pack.add({
	{ src = "https://github.com/hedyhli/outline.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
}, { load = true })

require("outline").setup({
	window = {
		position = "right",
		width = 40,
	},
})

require("toggleterm").setup({
	direction = "horizontal",
	open_mapping = "<leader>to",
})

-- Example mapping to toggle outline
vim.keymap.set("n", "<leader>so", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
