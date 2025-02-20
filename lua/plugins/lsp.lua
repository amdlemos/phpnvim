local map = vim.keymap.set
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

			require("plugins.lsp.intelephense")
			require("plugins.lsp.psalm")
			require("plugins.lsp.phan")
			require("plugins.lsp.emmet_language_server")
			require("plugins.lsp.html")
			require("plugins.lsp.eslint")
			require("plugins.lsp.astro")
			require("plugins.lsp.volar")

			-- Disabled
			-- require("plugins.lsp.ts_ls")
			-- require("plugins.lsp.vtsls")
			-- require("plugins.lsp.biome")
			-- require("plugins.lsp.phpactor")

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
