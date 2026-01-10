vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/famiu/bufdelete.nvim" },
}, { load = true })

local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "

keymap("n", "<space>", "<Nop>")

-- Gerenciamento de buffers
keymap("n", "<leader>bd", ":Bdelete<CR>", { desc = "Fechar buffer atual", silent = true })
keymap("n", "<leader>bD", ":Bdelete!<CR>", { desc = "Forçar fechar buffer atual", silent = true })
