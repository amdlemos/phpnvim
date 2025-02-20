return {
	{ "echasnovski/mini.tabline", version = "*" },
	{ "echasnovski/mini.pick", version = "*" },
	{
		"echasnovski/mini.icons",
		version = "*",
		config = function()
			require("mini.tabline").setup()
		end,
	},
}
