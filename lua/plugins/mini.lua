return {
	{ "echasnovski/mini.tabline", version = "*" },
	{
		"echasnovski/mini.icons",
		version = "*",
		config = function()
			require("mini.tabline").setup()
		end,
	},
}
