return {
	{ "onsails/lspkind.nvim" },
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		opts = {
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			-- make sure mason installs the server
			servers = {
				--- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
				--- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
				tsserver = {
					enabled = false,
				},
				ts_ls = {
					enabled = false,
				},
				vtsls = { enabled = false },
			},
		},
		dependencies = { "saghen/blink.cmp" },
		debug = true,
		enabled = true,
		config = function(_, opts)
			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				underline = true,
				severity_sort = true,
				update_in_insert = false,
			})

			local blink_capabilities = require("blink.cmp").get_lsp_capabilities()
			local lspconfig = require("lspconfig")

			-- default
			require("plugins.lsp.html").setup(lspconfig)
			require("plugins.lsp.css").setup(lspconfig)
			-- require("plugins.lsp.emmet_language_server").setup(lspconfig)
			-- lspconfig.htmx.setup({})
			-- require("plugins.lsp.sqlls").setup(lspconfig)
			-- require("plugins.lsp.sqls").setup(lspconfig)

			-- php
			require("plugins.lsp.intelephense").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.psalm").setup(lspconfig)
			require("plugins.lsp.phan").setup(lspconfig)
			-- require("plugins.lsp.twiggy_language_server").setup(lspconfig)

			-- ts/js
			require("plugins.lsp.astro").setup(lspconfig, blink_capabilities)

			-- require("plugins.lsp.vtsls").setup(lspconfig, blink_capabilities)
			-- require("plugins.lsp.ts_ls").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.volar").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.eslint").setup(lspconfig)

			-- ruby
			require("plugins.lsp.ruby_lsp").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.solargraph").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.sorbet").setup(lspconfig, blink_capabilities)

			-- Disabled
			require("plugins.lsp.biome").setup(lspconfig, blink_capabilities)
			-- require("plugins.lsp.phpactor").setup(lspconfig, blink_capabilities)
			-- local lspconfig = require("lspconfig")

			local keymap = vim.keymap
			local buf = vim.lsp.buf

			keymap.set({ "n", "v" }, "<leader>ca", buf.code_action, { desc = "LSP Code Action" })
		end,
	},
}
