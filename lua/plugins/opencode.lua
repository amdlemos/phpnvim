-- OpenCode.nvim Configuration
-- AI Assistant integration with Neovim

local opencode = require("opencode")
local keymap = vim.keymap.set
local s = { silent = true, desc = "" }

-- Configuração do snacks.nvim (dependência para opencode)
require("snacks").setup({
	input = {},
	picker = {},
	terminal = {},
})

-- Configuração do opencode
vim.g.opencode_opts = {
	-- Provider: usar terminal nativo do Neovim
	provider = {
		enabled = "terminal",
		terminal = {
			-- Configurações do terminal
		},
	},
	-- Eventos de reload automático
	events = {
		reload = true,
	},
}

-- Keymaps do OpenCode
-- Ask - fazer uma pergunta ao OpenCode
keymap({ "n", "x" }, "<leader>oa", function()
	opencode.ask("@this: ", { submit = false })
end, vim.tbl_extend("force", s, { desc = "Ask OpenCode" }))

-- Select - selecionar ação do OpenCode
keymap({ "n", "x" }, "<leader>os", function()
	opencode.select()
end, vim.tbl_extend("force", s, { desc = "Select OpenCode action" }))

-- Toggle - ativar/desativar OpenCode
keymap({ "n", "t" }, "<leader>oo", function()
	opencode.toggle()
end, vim.tbl_extend("force", s, { desc = "Toggle OpenCode" }))

-- Operator mode - adicionar contexto à query
-- go + motion = adicionar range ao opencode
keymap("n", "go", function()
	opencode.operator("@this ")
end, vim.tbl_extend("force", s, { desc = "Add range to OpenCode" }))

-- goo = adicionar linha inteira
keymap("n", "goo", function()
	opencode.operator("@this " .. "_")
end, vim.tbl_extend("force", s, { desc = "Add line to OpenCode" }))

-- Scroll commands
keymap("n", "<S-C-u>", function()
	opencode.command("session.half.page.up")
end, vim.tbl_extend("force", s, { desc = "Scroll OpenCode up" }))

keymap("n", "<S-C-d>", function()
	opencode.command("session.half.page.down")
end, vim.tbl_extend("force", s, { desc = "Scroll OpenCode down" }))

-- Atalhos úteis para gerenciamento de sessão
keymap("n", "<leader>oi", function()
	opencode.command("session.interrupt")
end, vim.tbl_extend("force", s, { desc = "Interrupt OpenCode session" }))

keymap("n", "<leader>ou", function()
	opencode.command("session.undo")
end, vim.tbl_extend("force", s, { desc = "Undo OpenCode action" }))

keymap("n", "<leader>or", function()
	opencode.command("session.redo")
end, vim.tbl_extend("force", s, { desc = "Redo OpenCode action" }))

-- Custom prompts via select
-- Define prompts comuns se quiser usar <leader>op<name>
local function prompt(name)
	return function()
		opencode.prompt(name)
	end
end

-- Explicar código
keymap({ "n", "x" }, "<leader>opx", prompt("explain"), vim.tbl_extend("force", s, { desc = "Explain code" }))

-- Revisar código
keymap({ "n", "x" }, "<leader>opv", prompt("review"), vim.tbl_extend("force", s, { desc = "Review code" }))

-- Otimizar código
keymap({ "n", "x" }, "<leader>opy", prompt("optimize"), vim.tbl_extend("force", s, { desc = "Optimize code" }))

-- Implementar função
keymap({ "n", "x" }, "<leader>opi", prompt("implement"), vim.tbl_extend("force", s, { desc = "Implement code" }))

-- Adicionar testes
keymap({ "n", "x" }, "<leader>opt", prompt("test"), vim.tbl_extend("force", s, { desc = "Add tests" }))

-- Documentar código
keymap({ "n", "x" }, "<leader>opd", prompt("document"), vim.tbl_extend("force", s, { desc = "Document code" }))

-- Fixar diagnostics
keymap({ "n", "x" }, "<leader>opf", prompt("fix"), vim.tbl_extend("force", s, { desc = "Fix diagnostics" }))
