-- if true then
-- 	return
-- end
vim.pack.add({
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
}, { load = true })

local map = vim.keymap.set

-- normal mode (provavelmente você já tem)
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")

map("i", "<C-h>", "<Esc><cmd>TmuxNavigateLeft<cr>")
map("i", "<C-j>", "<Esc><cmd>TmuxNavigateDown<cr>")
map("i", "<C-k>", "<Esc><cmd>TmuxNavigateUp<cr>")
map("i", "<C-l>", "<Esc><cmd>TmuxNavigateRight<cr>")

-- terminal mode (ESSENCIAL)
map("t", "<C-h>", [[<C-\><C-n><cmd>TmuxNavigateLeft<cr>]])
map("t", "<C-j>", [[<C-\><C-n><cmd>TmuxNavigateDown<cr>]])
map("t", "<C-k>", [[<C-\><C-n><cmd>TmuxNavigateUp<cr>]])
map("t", "<C-l>", [[<C-\><C-n><cmd>TmuxNavigateRight<cr>]])
