-- Treesitter Configuration

require("nvim-treesitter.configs").setup({
	-- Instalar parsers automaticamente
	ensure_installed = {
		"lua",
		"vim",
		"vimdoc",
		"php",
		"php_only",
		"phpdoc",
		"html",
		"css",
		"javascript",
		"typescript",
		"json",
		"yaml",
		"markdown",
		"markdown_inline",
		"bash",
		"regex",
		"dart",
		"blade",
		"vue",
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
		-- disable = { "lua" },
	},
	-- Seleção incremental com Treesitter
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<C-space>",
			node_incremental = "<C-space>",
			scope_incremental = false,
			node_decremental = "<bs>",
		},
	},
})
