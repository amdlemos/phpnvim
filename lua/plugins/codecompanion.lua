-- CodeCompanion Configuration

require("codecompanion").setup({
	interactions = {
		chat = {
			adapter = "gemini",
		},
	},
	opts = {
		log_level = "DEBUG",
	},
})

require("render-markdown").setup({
	ft = { "markdown", "codecompanion" },
})
