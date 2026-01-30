-- Themes Configuration

require("astrotheme").setup({})
require("onedark").setup({
	style = "deep",
	transparent = true,
	term_colors = false,
	ending_tildes = false,
	cmp_itemkind_reverse = false,
	toggle_style_key = "<leader>ot",
	toggle_style_list = { "dark", "darker", "cool", "warm", "warmer", "deep", "light" },
	code_style = {
		comments = "italic",
		keywords = "none",
		functions = "none",
		strings = "none",
		variables = "none",
	},
	lualine = { transparent = true },
	diagnostics = { darker = true, undercurl = true, background = false },
})

vim.keymap.set("n", "<leader>tc", '<CMD>lua require("onedark").toggle()<CR>')
vim.cmd([[colorscheme astrodark]])
