require("outline").setup({
	outline_window = {
		position = "right",
		width = 30,
		focus_on_open = false,
	},
})

vim.keymap.set("n", "<leader>so", "<cmd>Outline<cr>", { desc = "Símbolos do documento (Outline - lateral esquerda)" })
