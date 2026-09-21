-- Core Keymaps
-- Keymaps globais (não específicos de plugins ou LSP)

local keymap = vim.keymap.set

-- Leader
vim.g.mapleader = " "
keymap("n", "<space>", "<Nop>")

-- Clipboard configurado nativamente com o sistema em options.lua

-- Gerenciamento de buffers
keymap("n", "<leader>bd", function()
	require("mini.bufremove").delete(0, false)
end, { desc = "Fechar buffer atual", silent = true })
keymap("n", "<leader>bD", function()
	require("mini.bufremove").delete(0, true)
end, { desc = "Forçar fechar buffer atual", silent = true })

-- File Explorer (Neo-tree): keymaps <leader>e/be/ge definidos em plugins/neotree.lua
keymap("n", "<leader>E", "<cmd>Neotree toggle<cr>", { desc = "Abrir explorador de arquivos (root)", silent = true })

-- Git (Diffview & Conflict)
keymap("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Git: Ver Diff (projeto)" })
keymap("n", "<leader>gD", "<cmd>DiffviewOpen develop...HEAD<cr>", { desc = "Git: Diff develop...HEAD" })
keymap("n", "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Git: Fechar Diff" })
keymap("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "Git: Histórico do arquivo atual" })
keymap("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "Git: Histórico do projeto" })

-- Git: Diff do trabalho local contra a branch atual (HEAD)
-- AtlasDiff só aceita revisões que resolvem para commit, então índice e working tree usam Diffview.
keymap("n", "<leader>gS", "<cmd>DiffviewOpen --cached<cr>", { desc = "Git: Diff staged vs HEAD" })
keymap("n", "<leader>gu", "<cmd>DiffviewOpen<cr>", { desc = "Git: Diff unstaged (working tree vs índice)" })
keymap("n", "<leader>gw", "<cmd>DiffviewOpen HEAD<cr>", { desc = "Git: Diff staged + unstaged vs HEAD" })

-- Git: Gerenciamento de Hunks e Commit (MiniDiff & MiniGit)
-- keymap("n", "<leader>gs", "<cmd>lua MiniDiff.apply()<cr>", { desc = "Git: Stage/Aplicar hunk" })
-- keymap("n", "<leader>gr", "<cmd>lua MiniDiff.reset()<cr>", { desc = "Git: Reset/Descartar hunk" })
-- keymap("n", "<leader>gg", "<cmd>lua MiniGit.show_at_cursor()<cr>", { desc = "Git: Info de git no cursor" })
-- keymap("n", "<leader>gb", ":Git branch<cr>", { desc = "Git: Branches (MiniGit)" })
-- keymap("n", "<leader>gc", ":Git log<cr>", { desc = "Git: Commits (MiniGit)" })
-- keymap("n", "<leader>gm", ":Git commit<cr>", { desc = "Git: Commit (MiniGit)" })
-- keymap("n", "<leader>gp", ":Git push<cr>", { desc = "Git: Push (MiniGit)" })

-- Navegação no terminal: <C-h/j/k/l> em modo t definidos em plugins/tmux.lua (TmuxNavigate)
keymap("t", "<Esc>", "<C-\\><C-n>", { desc = "Sair do modo insert do terminal", silent = true })

-- Navegação entre tabs
keymap("n", "]t", "<cmd>tabnext<cr>", { desc = "Próxima tab", silent = true })
keymap("n", "[t", "<cmd>tabprevious<cr>", { desc = "Tab anterior", silent = true })
