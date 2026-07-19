-- nvim-treesitter (branch main) — Neovim 0.12+
-- Branch main não tem mais o módulo "configs": highlight/indent são ativados
-- via vim.treesitter.start() em autocmd de FileType.

local ts = require("nvim-treesitter")

ts.setup({})

-- Parsers garantidos (instalação assíncrona, no-op se já instalados)
local parsers = {
	-- Neovim / Lua
	"lua",
	"vim",
	"vimdoc",
	"query",
	-- PHP / Laravel
	"php",
	"php_only",
	"blade",
	-- Web
	"html",
	"css",
	"javascript",
	"typescript",
	"tsx",
	"json",
	"yaml",
	-- Dart / Flutter
	"dart",
	-- Diversos
	"markdown",
	"markdown_inline",
	"bash",
	"sql",
	"http",
	"regex",
	"diff",
	"gitcommit",
}

ts.install(parsers)

-- Ativa highlight e indentação do treesitter quando houver parser para o filetype
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreesitterAtivar", { clear = true }),
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start(args.buf, lang)
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
