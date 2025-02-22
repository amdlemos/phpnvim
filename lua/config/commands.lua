vim.cmd("colorscheme astromars")
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
