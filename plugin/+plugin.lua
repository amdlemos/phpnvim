vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
}, { load = true })

require("nvim-treesitter.configs").setup({
	highlight = {
		enable = false,
		additional_vim_regex_highlighting = false,
	},
})
