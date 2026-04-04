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

-- Definir ícones na sign column
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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
	keys = {
		l = "fold_open",
		h = "fold_close",
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
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- Redirecionar quickfix/loclist nativos para o Trouble
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	pattern = "[^l]*",
	callback = function()
		vim.cmd("Trouble qflist open")
	end,
	desc = "Abrir quickfix no Trouble",
})

vim.api.nvim_create_autocmd("QuickFixCmdPost", {
	pattern = "l*",
	callback = function()
		vim.cmd("Trouble loclist open")
	end,
	desc = "Abrir loclist no Trouble",
})
vim.keymap.set(
	"n",
	"<leader>xr",
	"<cmd>Trouble symbols pinned=true win.relative=win win.position=right<cr>",
	{ desc = "Show document symbols (Trouble)" }
)
