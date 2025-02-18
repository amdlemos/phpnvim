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
			require("plugins.lsp.intelephense")
			require("plugins.lsp.phpactor")
			require("plugins.lsp.psalm")
			require("plugins.lsp.phan")
		end,
	},
}
