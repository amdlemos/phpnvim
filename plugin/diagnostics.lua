-- if true then
-- 	return
-- end
vim.pack.add({
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
})

require("tiny-inline-diagnostic").setup()

require("trouble").setup({
	-- aqui você pode colocar configs, se quiser
	-- exemplo:
	-- auto_open = false,
	-- auto_close = true,
})

-- Keymaps (se não estiver usando lazy.nvim ou que gere automaticamente)
vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xx",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>ls", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>lD",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions/Refs (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xr",
	"<cmd>Trouble symbols pinned=true win.relative=win win.position=right<cr>",
	{ desc = "Show document symbols (Trouble)" }
)
