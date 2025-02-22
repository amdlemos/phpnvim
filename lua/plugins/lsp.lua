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
		dependencies = { "saghen/blink.cmp" },
		debug = true,
		enabled = true,
		config = function()
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
			require("plugins.lsp.emmet_language_server").setup(lspconfig)

			-- php
			require("plugins.lsp.intelephense").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.psalm").setup(lspconfig)
			require("plugins.lsp.phan").setup(lspconfig)
			require("plugins.lsp.eslint").setup(lspconfig)

			-- ts/js
			require("plugins.lsp.astro").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.ts_ls").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.volar").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.ruby_lsp").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.solargraph").setup(lspconfig, blink_capabilities)
			require("plugins.lsp.sorbet").setup(lspconfig, blink_capabilities)

			lspconfig.lua_ls.setup({
				on_attach = function(client)
					-- client.server_capabilities.documentFormattingProvider = false
					-- client.server_capabilities.documentRangeFormattingProvider = false
				end,
				capabilities = blink_capabilities,
				settings = {
					Lua = {
						format = { enable = false },
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			lspconfig.tailwindcss.setup({
				capabilities = blink_capabilities,
			})
			-- Disabled
			-- require("plugins.lsp.vtsls")
			-- require("plugins.lsp.biome")
			-- require("plugins.lsp.phpactor").setup(lspconfig, blink_capabilities)
			local keymap = vim.keymap
			local buf = vim.lsp.buf
			keymap.set("n", "K", buf.hover, { desc = "LSP Hover" })
			keymap.set("n", "gd", buf.definition, { desc = "LSP Definition" })
			keymap.set("n", "gD", buf.declaration, { desc = "LSP Declaration" })
			keymap.set("n", "gi", buf.implementation, { desc = "LSP implementation" })
			keymap.set("n", "gr", buf.references, { desc = "LSP References" })
			keymap.set("n", "rn", buf.rename, { desc = "LSP Rename" })
			-- keymap.set("n", "D", buf.type_definition, { desc = "LSP Definition" })
			keymap.set({ "n", "v" }, "<leader>ca", buf.code_action, { desc = "LSP Code Action" })
		end,
	},
}
