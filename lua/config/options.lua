-- Configuração global (aplica para todos os arquivos)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.db_ui_win_position = "right"

local options = {
	conceallevel = 0,
	concealcursor = "",
	foldmethod = "expr",
	foldexpr = "nvim_treesitter#foldexpr()", -- Para Tree-sitter

	-- user interface

	mouse = "a", -- disable mouse in neovim
	clipboard = "unnamedplus", -- neovim uses the system clipboard by default
	cursorline = true,
	showtabline = 0, -- hide tabline
	inccommand = "split", -- when performing substitution, show preview at the bottom
	timeoutlen = 300, -- time for user to finish a key combination
	updatetime = 200, -- faster completion
	virtualedit = "block", -- enable highlighting empty spaces
	splitbelow = true, -- when splitting horizontally, new window goes below
	splitright = true, -- when splitting vertically, new window goes to the right
	showmode = false, -- mode will be shown by statusline

	-- kickstart config
	list = true,
	listchars = { tab = "» ", trail = "·", nbsp = "␣" },

	-- tabs and indentations

	expandtab = true, -- convert tabs into spaces
	shiftwidth = 2, -- the number of spaces for each indentation
	tabstop = 2, -- the number of spaces for each tab

	-- number columns

	relativenumber = true, -- display relative line numbers
	number = true, -- display the current line number
	numberwidth = 4, -- the column width to display line numbers
	signcolumn = "yes",
	cmdheight = 0,

	-- text display

	foldlevelstart = 99, -- start with everything unfolded
	foldtext = "", -- keep the appearance of the first folded line

	wrap = false, -- do not wrap lines because it is ugly
	smartindent = true, -- automatic indentations
	scrolloff = 99, -- keep cursorline in the middle
	sidescrolloff = 6, -- minimul number of columns to the left and right of cursor

	fillchars = {
		eob = " ", -- removes annoying tilde at the bottom of short files
		fold = "-", -- replace dots with horizontal line to indicate folded sections
		vert = " ",
	},

	-- text search

	ignorecase = true, -- make search case-insensitive
	smartcase = true, -- but if our search contains uppercase(s), it becomes case-sensitive

	-- miscellaneous

	backup = false, -- do not create a backup file
	swapfile = false, -- do not create a swap file
	fileencoding = "utf-8", -- the encoding written to a file
	-- eol = true,
	-- fixeol = true,
}

-- Para .lua
for parameter, value in pairs(options) do
	vim.opt[parameter] = value
end
