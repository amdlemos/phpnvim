return {
	"nvim-treesitter/nvim-treesitter",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"json",
				"xml",
				"php_only",
				"phpdoc",
				"markdown_inline",
				"jsdoc",
				"tsx",
				"javascript",
				"typescript",
				"dockerfile",
				"ziggy",
				"ziggy_schema",
				"yaml",
				"tmux",
				"xcompose",
				"astro",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitattributes",
				"gitignore",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
				-- disable = { "lua" },
			},
		})
	end,
}
