vim.pack.add({
	{ src = "https://github.com/ibhagwan/fzf-lua" },
})

require("fzf-lua").setup({})

local keymap = vim.keymap.set
local s = { silent = true }

-- Busca de arquivos
keymap("n", "<leader>ff", "<cmd>FzfLua files<cr>", s)
keymap("n", "<leader>fa", "<cmd>FzfLua files cwd=~<cr>", s) -- todos arquivos do sistema
keymap("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", s) -- arquivos recentes

-- Busca de conteúdo (grep)
keymap("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", s) -- busca em tempo real
keymap("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>", s) -- busca palavra sob cursor
keymap("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", s) -- busca WORD sob cursor
keymap("n", "<leader>fv", "<cmd>FzfLua grep_visual<cr>", s) -- busca seleção visual
keymap("n", "<leader>fp", "<cmd>FzfLua grep_project<cr>", s) -- busca no projeto

-- Buffers e histórico
keymap("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", s) -- buffers abertos
keymap("n", "<leader>fh", "<cmd>FzfLua oldfiles<cr>", s) -- histórico de arquivos
keymap("n", "<leader>fq", "<cmd>FzfLua quickfix<cr>", s) -- quickfix list
keymap("n", "<leader>fl", "<cmd>FzfLua loclist<cr>", s) -- location list

-- Git
keymap("n", "<leader>gc", "<cmd>FzfLua git_commits<cr>", s) -- commits
keymap("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", s) -- status
keymap("n", "<leader>gb", "<cmd>FzfLua git_branches<cr>", s) -- branches
keymap("n", "<leader>gf", "<cmd>FzfLua git_files<cr>", s) -- arquivos git

-- LSP (se você usar)
keymap("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<cr>", s)
keymap("n", "<leader>lr", "<cmd>FzfLua lsp_references<cr>", s)
keymap("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", s)
keymap("n", "<leader>lw", "<cmd>FzfLua lsp_workspace_symbols<cr>", s)

-- Outros
keymap("n", "<leader>fc", "<cmd>FzfLua commands<cr>", s) -- comandos vim
keymap("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", s) -- keymaps
keymap("n", "<leader>fm", "<cmd>FzfLua marks<cr>", s) -- marks
keymap("n", "<leader>f:", "<cmd>FzfLua command_history<cr>", s) -- histórico comandos
keymap("n", "<leader>f/", "<cmd>FzfLua search_history<cr>", s) -- histórico buscas
