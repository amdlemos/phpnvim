-- Tmux Navigator Configuration

local map = vim.keymap.set

-- Normal mode
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<cr>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")

-- Insert mode
map("i", "<C-h>", "<Esc><cmd>TmuxNavigateLeft<cr>")
map("i", "<C-j>", "<Esc><cmd>TmuxNavigateDown<cr>")
map("i", "<C-k>", "<Esc><cmd>TmuxNavigateUp<cr>")
map("i", "<C-l>", "<Esc><cmd>TmuxNavigateRight<cr>")

-- Terminal mode
map("t", "<C-h>", [[<C-\><C-n><cmd>TmuxNavigateLeft<cr>]])
map("t", "<C-j>", [[<C-\><C-n><cmd>TmuxNavigateDown<cr>]])
map("t", "<C-k>", [[<C-\><C-n><cmd>TmuxNavigateUp<cr>]])
map("t", "<C-l>", [[<C-\><C-n><cmd>TmuxNavigateRight<cr>]])
