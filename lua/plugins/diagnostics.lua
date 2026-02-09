-- Diagnostics Configuration

vim.diagnostic.config({
	virtual_text = false,
	signs = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	underline = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	update_in_insert = false,
	severity_sort = true,
})

require("tiny-inline-diagnostic").setup({
	throttle = 200,
	filter = {
		severity = vim.diagnostic.severity.WARN,
	},
})

vim.keymap.set("n", "<leader>de", "<cmd>TinyInlineDiag enable<cr>", { desc = "Enable diagnostics" })
vim.keymap.set("n", "<leader>dd", "<cmd>TinyInlineDiag disable<cr>", { desc = "Disable diagnostics" })
vim.keymap.set("n", "<leader>dt", "<cmd>TinyInlineDiag toggle<cr>", { desc = "Toggle diagnostics" })

require("trouble").setup({
	auto_preview = false,
	max_items = 10,
	throttle = {
		refresh = 200,
		update = 100,
		render = 100,
		follow = 200,
	},
})

vim.keymap.set("n", "<leader>xX", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xx",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xl",
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
