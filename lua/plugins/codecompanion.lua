-- CodeCompanion.nvim Configuration
-- AI Assistant com suporte a GitHub Copilot (adapter padrão)
-- Docs: https://codecompanion.olimorris.dev

require("codecompanion").setup({
	-- Interactions: define qual adapter usar para cada tipo de interação
	interactions = {
		chat = {
			-- Copilot é o adapter padrão - funciona com assinatura GitHub Copilot Pro
			adapter = "copilot",
		},
		inline = {
			adapter = "copilot",
		},
		cmd = {
			adapter = "copilot",
		},
	},

	-- Display: configurações visuais
	display = {
		action_palette = {
			provider = "telescope",
		},
		chat = {
			-- Renderizar markdown no chat buffer
			render_headers = true,
		},
	},

	opts = {
		-- Nível de log (DEBUG, INFO, WARN, ERROR)
		log_level = "WARN",
	},
})

-- Keymaps do CodeCompanion
local keymap = vim.keymap.set

-- Action Palette - acessar todas as ações disponíveis
keymap({ "n", "v" }, "<leader>oa", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion: Action Palette", silent = true })

-- Toggle Chat - abrir/fechar chat buffer
keymap({ "n", "v" }, "<leader>oo", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "CodeCompanion: Toggle Chat", silent = true })

-- Chat Add - adicionar seleção visual ao chat atual
keymap("v", "<leader>oA", "<cmd>CodeCompanionChat Add<cr>", { desc = "CodeCompanion: Add to Chat", silent = true })

-- Inline - interação inline (escreve código direto no buffer)
keymap({ "n", "v" }, "<leader>oi", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion: Inline", silent = true })

-- Prompt Library - atalhos para prompts comuns
-- Explicar código selecionado
keymap({ "n", "v" }, "<leader>opx", "<cmd>CodeCompanion /explain<cr>", { desc = "CodeCompanion: Explain code", silent = true })

-- Fixar código selecionado
keymap({ "n", "v" }, "<leader>opf", "<cmd>CodeCompanion /fix<cr>", { desc = "CodeCompanion: Fix code", silent = true })

-- Gerar testes para código selecionado
keymap({ "n", "v" }, "<leader>opt", "<cmd>CodeCompanion /tests<cr>", { desc = "CodeCompanion: Generate tests", silent = true })

-- Explicar diagnósticos LSP
keymap({ "n", "v" }, "<leader>opl", "<cmd>CodeCompanion /lsp<cr>", { desc = "CodeCompanion: Explain LSP diagnostics", silent = true })

-- Gerar commit message
keymap("n", "<leader>opc", "<cmd>CodeCompanion /commit<cr>", { desc = "CodeCompanion: Generate commit msg", silent = true })

-- Atalho rápido: expandir 'cc' para 'CodeCompanion' na command line
vim.cmd([[cab cc CodeCompanion]])
