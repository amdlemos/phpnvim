vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	-- LSP
	-- { src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
	{ src = "https://github.com/neovim/nvim-lspconfig" },

	-- DAP
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
	{ src = "https://github.com/folke/lazydev.nvim" },

	-- Testing
	{ src = "https://github.com/vim-test/vim-test" },

	-- Formater
	{ src = "https://github.com/stevearc/conform.nvim" },

	-- Diagnostics
	{ src = "https://github.com/folke/trouble.nvim" },

	-- Themes
	{ src = "https://github.com/navarasu/onedark.nvim" },
	{ src = "https://github.com/AstroNvim/astrotheme" },

	-- Others
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/kdheepak/lazygit.nvim" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator" },
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/famiu/bufdelete.nvim" },
}, { load = true })

-- LSP
vim.lsp.enable({
	"bashls",
	"lua_ls",
	"intelephense",
	"ts_ls",
	"ruff",
	"turbo_ls",
	"tailwindcss",
	-- "phan",
	-- "phpactor",
	-- "psalm",
	-- "twiggy_language_server",
	-- "gopls",
	-- "texlab",
	-- "rust-analyzer",
	-- "helm_ls",
})
vim.diagnostic.config({ virtual_text = true })

-- require("mason").setup({})
require("lazydev").setup({
	library = { "nvim-dap-ui" },
})

require("astrotheme").setup({})
require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
	keymap = { preset = "default" },
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
	},
	completion = {
		documentation = {
			auto_show = true,
			-- auto_show_delay_ms = 200,
		},
	},
	-- cmdline = {
	-- 	keymap = {
	-- 		preset = "inherit",
	-- 		["<CR>"] = { "accept_and_enter", "fallback" },
	-- 	},
	-- },
	sources = {
		default = { "lazydev", "lsp" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 100,
			},
		},
	},
})
