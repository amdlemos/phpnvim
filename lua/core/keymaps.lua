-- Core Keymaps
-- Keymaps globais (não específicos de plugins ou LSP)

local keymap = vim.keymap.set

-- Leader
vim.g.mapleader = " "
keymap("n", "<space>", "<Nop>")

-- Clipboard: Copiar/Colar com registro do sistema (+)
-- Copiar seleção para clipboard do sistema
keymap({ "n", "x" }, "<leader>cy", '"+y', { desc = "Copiar para clipboard do sistema", silent = true })
-- Copiar linha inteira para clipboard
keymap("n", "<leader>cyy", '"+yy', { desc = "Copiar linha para clipboard do sistema", silent = true })
-- Copiar buffer inteiro para clipboard
keymap("n", "<leader>cya", 'gg"+yG', { desc = "Copiar tudo para clipboard do sistema", silent = true })
-- Colar do clipboard do sistema
keymap({ "n", "x" }, "<leader>cp", '"+p', { desc = "Colar do clipboard do sistema", silent = true })
-- Colar antes (insert before)
keymap({ "n", "x" }, "<leader>cP", '"+P', { desc = "Colar antes do clipboard do sistema", silent = true })

-- Gerenciamento de buffers
keymap("n", "<leader>bd", function()
	require("mini.bufremove").delete(0, false)
end, { desc = "Fechar buffer atual", silent = true })
keymap("n", "<leader>bD", function()
	require("mini.bufremove").delete(0, true)
end, { desc = "Forçar fechar buffer atual", silent = true })

-- File Explorer (MiniFiles)
keymap("n", "<leader>e", function()
	if not require("mini.files").close() then
		require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
	end
end, { desc = "Abrir explorador de arquivos (arquivo atual)", silent = true })

keymap("n", "<leader>E", function()
	if not require("mini.files").close() then
		require("mini.files").open(vim.loop.cwd(), true)
	end
end, { desc = "Abrir explorador de arquivos (root)", silent = true })

-- Git (Diffview & Conflict)
keymap("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git: Ver Diff (projeto)" })
keymap("n", "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Git: Fechar Diff" })
keymap("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Git: Histórico do arquivo atual" })
keymap("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Git: Histórico do projeto" })

-- Git: Gerenciamento de Hunks e Commit (MiniDiff & MiniGit)
keymap("n", "<leader>gs", "<cmd>lua MiniDiff.apply()<cr>", { desc = "Git: Stage/Aplicar hunk" })
keymap("n", "<leader>gr", "<cmd>lua MiniDiff.reset()<cr>", { desc = "Git: Reset/Descartar hunk" })
keymap("n", "<leader>gg", "<cmd>lua MiniGit.show_at_cursor()<cr>", { desc = "Git: Info de git no cursor" })
keymap("n", "<leader>gb", ":Git branch<cr>", { desc = "Git: Branches (MiniGit)" })
keymap("n", "<leader>gc", ":Git log<cr>", { desc = "Git: Commits (MiniGit)" })
keymap("n", "<leader>gm", ":Git commit<cr>", { desc = "Git: Commit (MiniGit)" })
keymap("n", "<leader>gp", ":Git push<cr>", { desc = "Git: Push (MiniGit)" })

-- Navegação no terminal
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Sair do modo insert do terminal", silent = true })
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Navegar para janela esquerda do terminal", silent = true })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Navegar para janela abaixo do terminal", silent = true })
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Navegar para janela acima do terminal", silent = true })
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Navegar para janela direita do terminal", silent = true })


