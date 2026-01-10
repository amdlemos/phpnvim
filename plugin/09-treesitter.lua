require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

vim.pack.add({
	{ src = "https://github.com/RicardoRamirezR/blade-nav.nvim" },
})
