vim.pack.add({
	{ src = "https://github.com/hedyhli/outline.nvim" },
	{ src = "https://github.com/akinsho/toggleterm.nvim" },
	{ src = "https://github.com/folke/edgy.nvim" },
}, { load = true })

require("outline").setup({
	-- window = {
	-- 	position = "right",
	-- 	width = 15,
	-- },
})

require("toggleterm").setup({
	open_mapping = "<leader>to",
	start_in_insert = false,
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

		{

			title = "Neotest outpanel",
			ft = "neotest-output-panel",
			size = { height = 0.1 },
		},
	},
	left = {
		{
			title = "Neo-Tree",
			ft = "neo-tree",
			pinned = true, -- ESSENCIAL: Mantém a referência mesmo se fechado
			size = { width = 0.2 },
		},

		{
			title = "Outline",
			ft = "Outline",
			pinned = true, -- ESSENCIAL: Mantém a referência mesmo se fechado
			size = { width = 0.2, height = 0.27 },
		},
	},
	right = {

		{
			title = "Neotest summary",
			ft = "neotest-summary",
			size = { width = 40 },
		},

		{
			ft = "dapui_watches",
			size = { width = 40 },
		},
		{ ft = "dap-repl", title = "REPL", size = { height = 10 } },
		{
			ft = "dapui_breakpoints",
			size = { width = 40 },

			size = { width = 0.2, height = 0.27 },
		},
	},
})
-- Toggle de todo o lado ESQUERDO
vim.keymap.set("n", "<leader>tl", function()
	require("edgy").toggle("left")
end, { desc = "Toggle Edgy Left" })
