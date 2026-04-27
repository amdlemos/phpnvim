-- Treesitter Configuration
-- Usa API nativa do Neovim (vim.treesitter) — nvim-treesitter rewrite não tem mais configs.setup()
-- O nvim-treesitter nesta versão fornece apenas: parsers, queries e install CLI
-- O highlight é ativado via autocmd FileType usando vim.treesitter.start()

-- Linguagens para ativar highlight automaticamente
local languages = {
	"bash", "blade", "css", "dart", "diff", "dockerfile",
	"git_config", "gitcommit", "gitignore",
	"html", "http", "javascript", "jsdoc", "json", "jsonc",
	"lua", "luadoc", "markdown", "markdown_inline",
	"php", "php_only", "phpdoc",
	"python", "regex", "rust",
	"scss", "sql", "toml", "tsx", "typescript",
	"vim", "vimdoc", "xml", "yaml",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function(args)
		local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype) or vim.bo[args.buf].filetype
		local ok = pcall(vim.treesitter.start, args.buf, lang)
		if not ok then
			-- Parser não disponível para essa linguagem, ignora silenciosamente
		end
	end,
	desc = "Ativar treesitter highlight nativo por FileType",
})

-- Instala parsers em falta ao abrir um arquivo (requer nvim-treesitter CLI)
local ensure_installed = languages
local function install_missing()
	local ok, install = pcall(require, "nvim-treesitter.install")
	if not ok then return end
	for _, lang in ipairs(ensure_installed) do
		local parser_path = vim.fn.stdpath("data") .. "/site/parser/" .. lang
		local ext = vim.fn.has("win32") == 1 and ".dll" or ".so"
		if vim.fn.filereadable(parser_path .. ext) == 0 then
			pcall(install.install, lang)
		end
	end
end

-- Roda install uma vez por sessão de forma assíncrona
vim.defer_fn(install_missing, 2000)
