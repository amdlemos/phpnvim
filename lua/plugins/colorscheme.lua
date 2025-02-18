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
					["bufferline.nvim"] = true,
					["nvim-tree"] = true,
				},
				palettes = {
					astromars = {
						ui = {
							current_line = color.new("#1E1517"):lighten(10):tohex(),
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
}
