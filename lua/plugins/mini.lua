return {
	{ "echasnovski/mini.tabline", version = "*" },
	{ "echasnovski/mini.pick", version = "*" },
	{
		"echasnovski/mini.splitjoin",
		version = "*",
		config = function()
			require("mini.splitjoin").setup({
				mappings = {
					toggle = "gs",
					split = "",
					join = "",
				},
			}
)
		end,
	},
	{
		"echasnovski/mini.icons",
		version = "*",
		config = function()
			require("mini.tabline").setup()
		end,
	},
}
