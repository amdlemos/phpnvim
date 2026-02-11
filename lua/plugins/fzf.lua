-- FZF-Lua Configuration (Minimalista)
-- Apenas: live_grep (real-time fuzzy grep) + LSP references
-- Tudo mais fica com mini.pick

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
		timeout = 3000,
		async_or_timeout = 5000,
		jump_to_single_result = true,
		jump_to_single_result_action = fzf.actions.file_edit,
	},
})

-- Live Grep - busca de conteúdo em tempo real com fuzzy
keymap("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", vim.tbl_extend("force", s, { desc = "Live Grep" }))
keymap("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", vim.tbl_extend("force", s, { desc = "Live Grep" }))

-- Grep - palavra sob cursor
keymap("n", "<leader>fw", "<cmd>FzfLua grep_cword<cr>", vim.tbl_extend("force", s, { desc = "Grep Word" }))
keymap("n", "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", vim.tbl_extend("force", s, { desc = "Grep WORD" }))

-- LSP - Referências (variáveis, classes, etc)
keymap("n", "<leader>lr", "<cmd>FzfLua lsp_references<cr>", vim.tbl_extend("force", s, { desc = "Referências (LSP)" }))

-- LSP - Workspace Symbols (busca global de símbolos)
keymap("n", "<leader>lw", "<cmd>FzfLua lsp_workspace_symbols<cr>", vim.tbl_extend("force", s, { desc = "Workspace Symbols" }))

-- LSP - Type Definition
keymap("n", "<leader>lt", "<cmd>FzfLua lsp_type_definitions<cr>", vim.tbl_extend("force", s, { desc = "Type Definition" }))

-- LSP - Implementação
keymap("n", "<leader>li", "<cmd>FzfLua lsp_implementations<cr>", vim.tbl_extend("force", s, { desc = "Implementação" }))
