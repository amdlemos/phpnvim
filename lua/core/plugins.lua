-- Core Plugins
-- ÚNICO ponto de declaração de plugins usando vim.pack.add
-- Nenhum outro arquivo deve chamar vim.pack.add

vim.pack.add({
	-- Dependências comuns
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/folke/lazydev.nvim" },

	-- LSP
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	-- Blade
	{ src = "https://github.com/RicardoRamirezR/blade-nav.nvim" },

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

	-- UI
	{ src = "https://github.com/navarasu/onedark.nvim" },
	{ src = "https://github.com/AstroNvim/astrotheme" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },

	-- File Explorer (Neo-tree)
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },

	-- Telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },

	-- IA
	{ src = "https://github.com/folke/sidekick.nvim" },
	-- OpenCode AI Assistant (substituído pelo CodeCompanion)
	-- { src = "https://github.com/nickjvandyke/opencode.nvim" },

	-- CodeCompanion - AI Assistant (usa GitHub Copilot como adapter padrão)
	-- { src = "https://github.com/olimorris/codecompanion.nvim" },

	-- Git
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	-- { src = "https://github.com/akinsho/git-conflict.nvim" },

	-- Tmux
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },

	-- Diagnostics
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },
	{ src = "https://github.com/folke/edgy.nvim" },
	-- Code Actions
	{ src = "https://github.com/rachartier/tiny-code-action.nvim" },

	-- Formatting
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- Completion
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/onsails/lspkind.nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
	{ src = "https://github.com/zbirenbaum/copilot.lua" },
	{ src = "https://github.com/giuxtaposition/blink-cmp-copilot" },

	-- DAP
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },

	-- Testing
	{ src = "https://github.com/nvim-neotest/neotest" },
	{ src = "https://github.com/olimorris/neotest-phpunit" },
	{ src = "https://github.com/V13Axel/neotest-pest" },

	-- Markdown
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
}, { load = true })
