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

	-- Treesitter (gerenciador de parsers - substitui nvim-treesitter)
	{ src = "https://github.com/romus204/tree-sitter-manager.nvim" },

	-- UI
	{ src = "https://github.com/navarasu/onedark.nvim" },
	{ src = "https://github.com/AstroNvim/astrotheme" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },

	-- File Explorer (Neo-tree)
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/hedyhli/outline.nvim" },

	-- Telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-ui-select.nvim" },

	-- OpenCode AI Assistant
	{ src = "https://github.com/nickjvandyke/opencode.nvim" },

	-- Git
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/sindrets/diffview.nvim" },
	{ src = "https://github.com/akinsho/git-conflict.nvim" },

	-- Terminal
	{ src = "https://github.com/akinsho/toggleterm.nvim" },

	-- Tmux
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },

	-- Buffer management (agora via mini.bufremove)

	-- Diagnostics
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },

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

	-- Markdown
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
}, { load = true })
