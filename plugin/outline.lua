vim.pack.add({
	{ src = "https://github.com/hedyhli/outline.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/folke/edgy.nvim" },
}, { load = true })

require("outline").setup({})

require("toggleterm").setup({
	open_mapping = "<leader>to",
})

vim.keymap.set("n", "<leader>so", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

-- edgy.nvim setup for managing window layouts
require("edgy").setup({
	animate = {
		enabled = false,
	},
	bottom = {
		{
			title = "Terminal",
			ft = "toggleterm",
			size = { height = 0.1 },
		},
		{

			title = "Trouble",
			ft = "trouble",
			size = { height = 0.1 },
		},
	},
	left = {
		{
			title = "Neo-Tree",
			ft = "neo-tree",
			size = { width = 0.2 },
		},
	},
	right = {
		{
			title = "Outline",
			ft = "Outline",
			size = { width = 0.15 },
		},
	},
})
