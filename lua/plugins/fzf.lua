-- FZF-Lua Configuration

require("fzf-lua").setup({})

local keymap = vim.keymap.set
local s = { silent = true }

-- Busca de arquivos
keymap("n", "<leader>ff", "<cmd>FzfLua files<cr>", s)
keymap("n", "<leader>fa", "<cmd>FzfLua files cwd=~<cr>", s)
keymap("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", s)

-- Busca de conteúdo (grep)
keymap("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", s)
keymap("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>", s)
keymap("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", s)
keymap("n", "<leader>fv", "<cmd>FzfLua grep_visual<cr>", s)
keymap("n", "<leader>fp", "<cmd>FzfLua grep_project<cr>", s)

-- Buffers e histórico
keymap("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", s)
keymap("n", "<leader>fh", "<cmd>FzfLua oldfiles<cr>", s)
keymap("n", "<leader>fq", "<cmd>FzfLua quickfix<cr>", s)
keymap("n", "<leader>fl", "<cmd>FzfLua loclist<cr>", s)

-- Git
keymap("n", "<leader>gc", "<cmd>FzfLua git_commits<cr>", s)
keymap("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", s)
keymap("n", "<leader>gb", "<cmd>FzfLua git_branches<cr>", s)
keymap("n", "<leader>gf", "<cmd>FzfLua git_files<cr>", s)

-- LSP
keymap("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<cr>", s)
keymap("n", "<leader>lr", "<cmd>FzfLua lsp_references<cr>", s)
keymap("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", s)
keymap("n", "<leader>lw", "<cmd>FzfLua lsp_workspace_symbols<cr>", s)

-- Outros
keymap("n", "<leader>fc", "<cmd>FzfLua commands<cr>", s)
keymap("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", s)
keymap("n", "<leader>fm", "<cmd>FzfLua marks<cr>", s)
keymap("n", "<leader>f:", "<cmd>FzfLua command_history<cr>", s)
keymap("n", "<leader>f/", "<cmd>FzfLua search_history<cr>", s)
