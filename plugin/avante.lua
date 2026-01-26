-- if true then
-- 	return
-- end
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/folke/snacks.nvim" },
	-- { src = "https://github.com/stevearc/dressing.nvim" },
	{ src = "https://github.com/hrsh7th/nvim-cmp" },
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

	{ src = "https://github.com/junegunn/fzf.vim" },
	{ src = "https://github.com/hakonharnes/img-clip.nvim" },
	{ src = "https://github.com/github/copilot.vim" },
	{ src = "https://github.com/yetone/avante.nvim" },
}, { load = true })
-- deps:
require("cmp").setup({
	-- use recommended settings from above
})
require("img-clip").setup({
	-- use recommended settings from above
})
-- require("copilot").setup({
-- 	-- use recommended settings from above
-- })
require("render-markdown").setup({
	ft = { "markdown", "codecompanion" },
	-- use recommended settings from above
})
require("avante").setup({
	-- Example: Using snacks.nvim as input provider
	build = function()
		-- conditionally use the correct build system for the current OS
		if vim.fn.has("win32") == 1 then
			return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		else
			return "make"
		end
	end,
	opts = {
		-- add any opts here
		-- for example
		provider = "copilot",
	},
	input = {
		provider = "snacks", -- "native" | "dressing" | "snacks"
		provider_opts = {
			-- Snacks input configuration
			title = "Avante Input",
			icon = " ",
			placeholder = "Enter your API key...",
		},
	},
	-- Your other config here!
})
