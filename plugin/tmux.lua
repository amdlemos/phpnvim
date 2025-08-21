local keymap = vim.keymap.set
local s = { silent = true }

-- Tmux Navigator
keymap("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", s)
keymap("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", s)
keymap("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", s)
keymap("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", s)
keymap("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", s)
