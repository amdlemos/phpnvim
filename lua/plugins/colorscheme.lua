return {
	{
		"AstroNvim/astrotheme",
		lazy = false,
		config = function()
			local color = require("astrotheme.lib.color")
			require("astrotheme").setup({
				style = {
					inactive = false,
					-- transparent = true,
				},
				plugins = {
					["snacks"] = true,
					["blink-cmp"] = true,
					["lazy"] = true,
				},
				palettes = {
					astromars = {
						ui = {
							current_line = color.new("#1E1517"):lighten(10):tohex(),
							-- text_inactive = color.new("#BF00FF"):lighten(10):tohex(),
							-- inactive_base = color.new("#BF00FF"):lighten(10):tohex(),
							none_text = color.new("#8B7079"):lighten(10):tohex(),
						},
					},
					astrojupiter = {
						ui = {
							current_line = color.new("#F6DDD8"):lighten(50):tohex(),
						},
					},
				},
			})
		end,
	},
	{ "bluz71/vim-moonfly-colors", name = "moonfly" },
	{ "bluz71/vim-nightfly-colors", name = "nightfly" },
	{
		"folke/tokyonight.nvim",
		opts = {},
	},
	{ "L-Colombo/oldschool.nvim" },
}
