-- if true then
-- 	return
-- end
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
}, { load = true })

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

local keymap = vim.keymap.set
local s = { silent = true }

-- Nvim Tree
keymap("n", "<leader>e", "<cmd>Neotree toggle<CR>", s)
