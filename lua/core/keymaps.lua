-- Core Keymaps
-- Keymaps globais (não específicos de plugins ou LSP)

local keymap = vim.keymap.set

-- Leader
vim.g.mapleader = " "
keymap("n", "<space>", "<Nop>")

-- Gerenciamento de buffers
keymap("n", "<leader>bd", ":Bdelete<CR>", { desc = "Fechar buffer atual", silent = true })
keymap("n", "<leader>bD", ":Bdelete!<CR>", { desc = "Forçar fechar buffer atual", silent = true })

-- Navegação no terminal
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Sair do modo insert do terminal", silent = true })
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Navegar para janela esquerda do terminal", silent = true })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Navegar para janela abaixo do terminal", silent = true })
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Navegar para janela acima do terminal", silent = true })
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Navegar para janela direita do terminal", silent = true })

