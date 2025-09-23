local keymap = vim.keymap.set
local s = { silent = true }

vim.g.mapleader = " "

keymap("n", "<space>", "<Nop>")

-- Keymaps de teste (apenas vim-test)
keymap("n", "<leader>tt", ":TestNearest<CR>", { desc = "Executar teste mais próximo", silent = true })
keymap("n", "<leader>tf", ":TestFile<CR>", { desc = "Executar testes do arquivo atual", silent = true })
keymap("n", "<leader>tl", ":TestLast<CR>", { desc = "Repetir último teste", silent = true })
keymap("n", "<leader>tv", ":TestVisit<CR>", { desc = "Ir para arquivo de teste", silent = true })

-- Keymaps para melhorar navegação no terminal
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Sair do modo insert do terminal", silent = true })
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Navegar para janela esquerda do terminal", silent = true })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Navegar para janela abaixo do terminal", silent = true })
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Navegar para janela acima do terminal", silent = true })
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Navegar para janela direita do terminal", silent = true })

-- Gerenciamento de buffers
keymap("n", "<leader>bd", ":Bdelete<CR>", { desc = "Fechar buffer atual", silent = true })
keymap("n", "<leader>bD", ":Bdelete!<CR>", { desc = "Forçar fechar buffer atual", silent = true })
