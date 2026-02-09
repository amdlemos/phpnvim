-- FZF-Lua Configuration
-- Busca ultra-rápida com foco em performance e LSP

local fzf = require("fzf-lua")
local keymap = vim.keymap.set
local s = { silent = true, desc = "" }

-- Configuração otimizada para performance
fzf.setup({
	"telescope",
	winopts = {
		height = 0.85,
		width = 0.80,
		row = 0.30,
		col = 0.50,
		border = "rounded",
		preview = {
			layout = "flex",
			flip_columns = 120,
		},
	},
	keymap = {
		builtin = {
			["<C-d>"] = "preview-page-down",
			["<C-u>"] = "preview-page-up",
			["<C-q>"] = "select-all+accept",
		},
		fzf = {
			["ctrl-k"] = "up",
			["ctrl-j"] = "down",
			["ctrl-a"] = "toggle-all",
		},
	},
	-- Otimizações para LSP
	lsp = {
		timeout = 3000, -- timeout mais rápido para LSP
		async_or_timeout = 5000,
		jump_to_single_result = true, -- ir direto se só houver um resultado
		jump_to_single_result_action = fzf.actions.file_edit,
	},
	-- Performance para projetos grandes
	files = {
		cmd = "rg --files --hidden --color=never --glob=!{.git,node_modules}",
	},
})

-- Arquivos e busca
keymap("n", "<leader>ff", "<cmd>FzfLua files<cr>", vim.tbl_extend("force", s, { desc = "Files (FZF)" }))
keymap("n", "<leader>fa", "<cmd>FzfLua files cwd=~<cr>", vim.tbl_extend("force", s, { desc = "All Files (FZF)" }))
keymap("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", vim.tbl_extend("force", s, { desc = "Recent Files (FZF)" }))

-- Grep - busca de conteúdo
keymap("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", vim.tbl_extend("force", s, { desc = "Live Grep (FZF)" }))
keymap("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", vim.tbl_extend("force", s, { desc = "Grep (FZF)" }))
keymap("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>", vim.tbl_extend("force", s, { desc = "Grep Word (FZF)" }))
keymap("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", vim.tbl_extend("force", s, { desc = "Grep WORD (FZF)" }))

-- Buffers e histórico
keymap("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", vim.tbl_extend("force", s, { desc = "Buffers (FZF)" }))
keymap("n", "<leader>fh", "<cmd>FzfLua oldfiles<cr>", vim.tbl_extend("force", s, { desc = "History (FZF)" }))
keymap("n", "<leader>fq", "<cmd>FzfLua quickfix<cr>", vim.tbl_extend("force", s, { desc = "Quickfix (FZF)" }))

-- Git
keymap("n", "<leader>g", "", { desc = "Git (FZF)" })
keymap("n", "<leader>gf", "<cmd>FzfLua git_files<cr>", vim.tbl_extend("force", s, { desc = "Git Files (FZF)" }))
keymap("n", "<leader>gs", "<cmd>FzfLua git_status<cr>", vim.tbl_extend("force", s, { desc = "Git Status (FZF)" }))
keymap("n", "<leader>gc", "<cmd>FzfLua git_commits<cr>", vim.tbl_extend("force", s, { desc = "Git Commits (FZF)" }))
keymap("n", "<leader>gb", "<cmd>FzfLua git_branches<cr>", vim.tbl_extend("force", s, { desc = "Git Branches (FZF)" }))

-- LSP - FOCO ESPECIAL EM DEFINITIONS, REFERENCES, CODE ACTIONS
keymap("n", "<leader>l", "", { desc = "LSP (FZF)" })
keymap("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<cr>", vim.tbl_extend("force", s, { desc = "Go to Definition (FZF)" }))
keymap("n", "<leader>lr", "<cmd>FzfLua lsp_references<cr>", vim.tbl_extend("force", s, { desc = "References (FZF)" }))
keymap("n", "<leader>li", "<cmd>FzfLua lsp_implementations<cr>", vim.tbl_extend("force", s, { desc = "Go to Implementation (FZF)" }))
keymap("n", "<leader>lt", "<cmd>FzfLua lsp_type_definitions<cr>", vim.tbl_extend("force", s, { desc = "Type Definition (FZF)" }))
keymap("n", "<leader>ls", "<cmd>FzfLua lsp_document_symbols<cr>", vim.tbl_extend("force", s, { desc = "Document Symbols (FZF)" }))
keymap("n", "<leader>lw", "<cmd>FzfLua lsp_workspace_symbols<cr>", vim.tbl_extend("force", s, { desc = "Workspace Symbols (FZF)" }))
keymap("n", "<leader>lD", "<cmd>FzfLua diagnostics_document<cr>", vim.tbl_extend("force", s, { desc = "Document Diagnostics (FZF)" }))
keymap("n", "<leader>lW", "<cmd>FzfLua diagnostics_workspace<cr>", vim.tbl_extend("force", s, { desc = "Workspace Diagnostics (FZF)" }))

-- Outras funcionalidades úteis
keymap("n", "<leader>fc", "<cmd>FzfLua commands<cr>", vim.tbl_extend("force", s, { desc = "Commands (FZF)" }))
keymap("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", vim.tbl_extend("force", s, { desc = "Keymaps (FZF)" }))
keymap("n", "<leader>fm", "<cmd>FzfLua marks<cr>", vim.tbl_extend("force", s, { desc = "Marks (FZF)" }))
keymap("n", "<leader>f:", "<cmd>FzfLua command_history<cr>", vim.tbl_extend("force", s, { desc = "Command History (FZF)" }))
keymap("n", "<leader>f/", "<cmd>FzfLua search_history<cr>", vim.tbl_extend("force", s, { desc = "Search History (FZF)" }))

-- Help
keymap("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>", vim.tbl_extend("force", s, { desc = "Help Tags (FZF)" }))
