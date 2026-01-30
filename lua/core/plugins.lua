-- Core Plugins
-- ÚNICO ponto de declaração de plugins usando vim.pack.add
-- Nenhum outro arquivo deve chamar vim.pack.add

vim.pack.add({
	-- Dependências comuns
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/folke/lazydev.nvim" },

	-- LSP
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	-- Treesitter
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/RicardoRamirezR/blade-nav.nvim" },
	{ src = "https://github.com/antoinemadec/FixCursorHold.nvim" },

	-- UI
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/akinsho/bufferline.nvim" },
	{ src = "https://github.com/navarasu/onedark.nvim" },
	{ src = "https://github.com/AstroNvim/astrotheme" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
	{ src = "https://github.com/nvim-mini/mini.icons", branch = "stable" },
	{ src = "https://github.com/nvim-mini/mini.diff", branch = "stable" },

	-- File Explorer
	{ src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/hedyhli/outline.nvim" },
	{ src = "https://github.com/folke/edgy.nvim" },

	-- Telescope
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-frecency.nvim" },

	-- FZF
	{ src = "https://github.com/junegunn/fzf.vim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },

	-- Git
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	-- Terminal
	{ src = "https://github.com/akinsho/toggleterm.nvim" },

	-- Tmux
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },

	-- Buffer management
	{ src = "https://github.com/famiu/bufdelete.nvim" },

	-- Diagnostics
	{ src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim" },
	{ src = "https://github.com/folke/trouble.nvim" },

	-- Formatting
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- Linting
	{ src = "https://github.com/nvimtools/none-ls.nvim" },

	-- Completion
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/onsails/lspkind.nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
	{ src = "https://github.com/nvim-mini/mini.pick" },

	-- DAP
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },

	-- Testing
	{ src = "https://github.com/nvim-neotest/neotest" },
	{ src = "https://github.com/olimorris/neotest-phpunit" },

	-- Laravel
	{ src = "https://github.com/adibhanna/laravel.nvim" },

	-- Markdown
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

	-- AI/Code Companion
	-- { src = "https://github.com/olimorris/codecompanion.nvim", version = vim.version.range("^18.0.0") },
	-- { src = "https://github.com/yetone/avante.nvim" },
	-- { src = "https://github.com/github/copilot.vim" },
	-- { src = "https://github.com/hakonharnes/img-clip.nvim" },
}, { load = true })
