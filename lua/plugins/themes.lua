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
	diagnostics = { darker = true, undercurl = true, background = false },
})

require("tokyonight").setup({
	style = "night",
	transparent = true,
	terminal_colors = false,
	styles = {
		comments = { italic = true },
		keywords = { bold = false },
	},
})

vim.keymap.set("n", "<leader>tc", '<CMD>lua require("onedark").toggle()<CR>')
vim.keymap.set("n", "<leader>tt", "<cmd>colorscheme opencode<cr>", { desc = "OpenCode theme" })
vim.cmd([[colorscheme astrodark]])
