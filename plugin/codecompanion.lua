vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
	{
		src = "https://github.com/olimorris/codecompanion.nvim",
		version = vim.version.range("^18.0.0"),
	},
}, { load = true })

-- Other package managers
require("codecompanion").setup({
	interactions = {
		chat = {
			adapter = "gemini",
			-- model = "claude-sonnet-4-20250514",
		},
	},
	opts = {
		log_level = "DEBUG",
	},
})

require("render-markdown").setup({
	ft = { "markdown", "codecompanion" },
	-- use recommended settings from above
})
