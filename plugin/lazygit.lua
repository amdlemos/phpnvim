local keymap = vim.keymap.set
local s = { silent = true }

-- LazyGit
keymap("n", "<leader>gg", "<cmd>LazyGit<cr>", s)
keymap("n", "<leader>gc", "<cmd>LazyGitConfig<cr>", s)
keymap("n", "<leader>gf", "<cmd>LazyGitCurrentFile<cr>", s)
keymap("n", "<leader>glf", "<cmd>LazyGitFilter<cr>", s)
keymap("n", "<leader>glcf", "<cmd>LazyGitFilterCurrentFile<cr>", s)
