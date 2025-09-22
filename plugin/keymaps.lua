local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "

keymap("n", "<space>", "<Nop>")

-- Keymaps de teste (apenas vim-test)
keymap("n", "<leader>tt", ":TestNearest<CR>", { desc = "Executar teste mais próximo", silent = true })
keymap("n", "<leader>tf", ":TestFile<CR>", { desc = "Executar testes do arquivo atual", silent = true })
keymap("n", "<leader>tl", ":TestLast<CR>", { desc = "Repetir último teste", silent = true })
keymap("n", "<leader>tv", ":TestVisit<CR>", { desc = "Ir para arquivo de teste", silent = true })
