-- Sidekick.nvim Configuration
-- Docs: https://github.com/folke/sidekick.nvim
-- Funcionalidades:
--   NES: Next Edit Suggestions via GitHub Copilot
--   CLI: Interface para ferramentas de AI CLI (opencode, copilot, claude, etc.)

require("sidekick").setup({
	-- NES: Next Edit Suggestions
	nes = {
		enabled = true,
		debounce = 100,
		diff = {
			inline = "words", -- "words" | "chars" | false
			show = "always",  -- "always" | "cursor"
		},
		signs = true,
		jumplist = true,
	},

	-- CLI: Ferramentas de AI via terminal integrado
	cli = {
		watch = true, -- notifica o Neovim de mudanças de arquivos feitas por ferramentas AI
		win = {
			layout = "right",
			split = {
				width = 75,
				height = 20,
			},
            keys = {
                escape = { "<Esc>", "<c-[>", mode = "t" },
            },
		},
		picker = "telescope",
	},

	-- Copilot: rastrear status dos LSP do Copilot
	copilot = {
		status = {
			enabled = true,
			level = vim.log.levels.WARN,
		},
	},
})

-- Keymaps
local map = vim.keymap.set

-- NES: aplicar ou pular para próxima sugestão
map({ "n", "x" }, "<Tab>", function()
	if not require("sidekick").nes_jump_or_apply() then
		return "<Tab>"
	end
end, { desc = "Sidekick: NES jump/apply", expr = true, silent = true })

-- Opencode: toggle painel via tmux split
map("n", "<leader>st", "<cmd>Sidekick cli toggle tool=opencode<cr>", { desc = "Sidekick: Toggle opencode", silent = true })

-- Copilot CLI: toggle painel via tmux split
-- Requer: npm install -g @githubnext/copilot-cli
map("n", "<leader>sk", "<cmd>Sidekick cli toggle tool=copilot<cr>", { desc = "Sidekick: Toggle copilot CLI", silent = true })

-- CLI: selecionar qual tool abrir via Telescope
map("n", "<leader>ss", "<cmd>Sidekick cli select<cr>", { desc = "Sidekick: Select AI tool", silent = true })

-- CLI: enviar contexto/prompt para a sessão ativa
map({ "n", "v" }, "<leader>sp", "<cmd>Sidekick cli prompt<cr>", { desc = "Sidekick: Send prompt", silent = true })

-- NES: toggle NES (ativar/desativar sugestões)
map("n", "<leader>sn", "<cmd>Sidekick nes toggle<cr>", { desc = "Sidekick: Toggle NES", silent = true })

-- NES: limpar sugestão atual
map("n", "<leader>sc", "<cmd>Sidekick nes clear<cr>", { desc = "Sidekick: Clear NES", silent = true })
