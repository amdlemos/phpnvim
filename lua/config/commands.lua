vim.cmd("colorscheme astrodark")
vim.cmd("set termguicolors")

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.api.nvim_set_keymap("n", "]t", ":tabnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[t", ":tabprevious<CR>", { noremap = true, silent = true })
vim.cmd([[autocmd BufReadPost,FileReadPost * normal zM]])
vim.cmd("filetype plugin indent on")
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.ofx",
	callback = function()
		vim.bo.filetype = "xml"
	end,
})

local diagnostics_active = true

function ToggleDiagnostics()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.enable()
		vim.notify("Diagnostics ON", vim.log.levels.INFO)
	else
		vim.diagnostic.disable()
		vim.notify("Diagnostics OFF", vim.log.levels.WARN)
	end
end

vim.keymap.set("n", "<leader>xd", ToggleDiagnostics, { desc = "Toggle LSP diagnostics" })
