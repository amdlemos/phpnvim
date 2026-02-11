-- Mini Fuzzy Configuration
-- Fuzzy finder minimalista para: arquivos, buffers, comandos, símbolos

local pick = require("mini.pick")
local keymap = vim.keymap.set
local s = { silent = true, desc = "" }

-- Configuração do mini.fuzzy (matching avançado)
require("mini.fuzzy").setup()

-- Configuração do mini.pick com integração ao fuzzy
pick.setup({
	delay = {
		async = 10,
		busy = 50,
	},
	mappings = {
		caret_left = "<Left>",
		caret_right = "<Right>",
		caret_start = "<Home>",
		caret_end = "<End>",
		clear_left = "<C-u>",
		clear_right = "<C-w>",
		delete = "<BS>",
		delete_char = "<Del>",
		close = "<Esc>",
		scroll_down = "<C-j>",
		scroll_up = "<C-k>",
		scroll_page_down = "<C-d>",
		scroll_page_up = "<C-u>",
		toggle_preview = "<Tab>",
		move_down = "<Down>",
		move_up = "<Up>",
		move_start = "<PageUp>",
		move_end = "<PageDown>",
		paste = "<C-r>",
		refine = "<C-s>",
		refine_new = "<C-x>",
		stop = "<C-c>",
	},
	window = {
		config = function()
			return {
				anchor = "NW",
				col = math.floor(0.05 * vim.o.columns),
				height = math.floor(0.5 * vim.o.lines),
				row = math.floor(0.25 * vim.o.lines),
				width = math.floor(0.9 * vim.o.columns),
			}
		end,
		prompt_prefix = "  ",
	},
	sort = pick.default_sort,
})

-- Arquivos do projeto
keymap("n", "<leader>ff", pick.builtin.files, vim.tbl_extend("force", s, { desc = "Arquivos (projeto)" }))

-- Arquivos recentes
keymap("n", "<leader>fr", pick.builtin.oldfiles, vim.tbl_extend("force", s, { desc = "Arquivos recentes" }))

-- Todos os arquivos (home)
keymap("n", "<leader>fa", function()
	pick.builtin.files({ source = { cwd = vim.fn.expand("~") } })
end, vim.tbl_extend("force", s, { desc = "Todos os arquivos" }))

-- Buffers
keymap("n", "<leader>fb", pick.builtin.buffers, vim.tbl_extend("force", s, { desc = "Buffers" }))

-- Histórico
keymap("n", "<leader>fh", pick.builtin.oldfiles, vim.tbl_extend("force", s, { desc = "Histórico" }))

-- Comandos
keymap("n", "<leader>fc", pick.builtin.commands, vim.tbl_extend("force", s, { desc = "Comandos" }))

-- Marks
keymap("n", "<leader>fm", pick.builtin.marks, vim.tbl_extend("force", s, { desc = "Marks" }))

-- Símbolos do documento (treesitter)
keymap("n", "<leader>ls", pick.builtin.treesitter, vim.tbl_extend("force", s, { desc = "Símbolos (documento)" }))

-- Git Files (via mini.pick)
keymap("n", "<leader>gf", function()
	pick.builtin.files({ source = { cwd_type = "git_root" } })
end, vim.tbl_extend("force", s, { desc = "Git Files" }))

-- Code Action (nativo minimalista)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", s, { desc = "Code Action" }))

-- Diagnostic (Trouble)
keymap("n", "<leader>lD", "<cmd>Trouble document_diagnostics<cr>", vim.tbl_extend("force", s, { desc = "Diagnostics (documento)" }))
keymap("n", "<leader>lW", "<cmd>Trouble workspace_diagnostics<cr>", vim.tbl_extend("force", s, { desc = "Diagnostics (workspace)" }))
