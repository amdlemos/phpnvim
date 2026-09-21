-- nvim-lint: linters externos que não são language servers
-- PHP: phpmd (PHP Mess Detector) e phpstan (análise estática)

local lint = require("lint")

-- Regras padrão do phpmd quando o projeto não tem arquivo de ruleset próprio.
-- "controversial" fica de fora porque acusa convenções comuns de Laravel
-- (superglobais, nomes camelCase de propriedades, etc).
local default_rulesets = "cleancode,codesize,design,naming,unusedcode"

-- Procura um ruleset do projeto subindo a partir do arquivo aberto.
local function resolve_ruleset()
	local buf_dir = vim.fn.expand("%:p:h")
	if buf_dir == "" then
		buf_dir = vim.fn.getcwd()
	end

	local found = vim.fs.find({ "phpmd.xml", "phpmd.xml.dist", "ruleset.xml" }, {
		upward = true,
		path = buf_dir,
		type = "file",
	})[1]

	return found or default_rulesets
end

lint.linters.phpmd.args = {
	"-",
	"json",
	resolve_ruleset,
}

-- Regras do phpmd que nunca viram diagnóstico, independente do ruleset usado.
-- StaticAccess acusa qualquer chamada estática (facades do Laravel, helpers, etc).
local ignored_rules = {
	StaticAccess = true,
}

local phpmd_parser = lint.linters.phpmd.parser
lint.linters.phpmd.parser = function(output, bufnr, ...)
	return vim.tbl_filter(function(diagnostic)
		return not ignored_rules[diagnostic.code]
	end, phpmd_parser(output, bufnr, ...))
end

-- phpmd é rápido (~100ms) e pode rodar a cada saída do modo de inserção.
-- phpstan leva vários segundos, então roda só ao abrir e ao salvar o arquivo.
local fast_linters = { "phpmd" }
local slow_linters = { "phpstan" }

lint.linters_by_ft = {
	php = { "phpmd", "phpstan" },
}

-- O phpstan estoura o limite de memória padrão do PHP (128M) em projetos
-- grandes e devolve saída vazia, sem diagnóstico nenhum.
table.insert(lint.linters.phpstan.args, "--memory-limit=1G")

-- Só roda o linter se o executável existir (global no PATH ou em vendor/bin do
-- projeto). Sem isso o nvim-lint falha em silêncio e nenhum diagnóstico aparece.
local missing_warned = {}

local function available(names)
	local found = {}
	for _, name in ipairs(names) do
		local linter = lint.linters[name]
		local cmd = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
		if vim.fn.executable(cmd) == 1 then
			found[#found + 1] = name
		elseif not missing_warned[name] then
			missing_warned[name] = true
			vim.notify(("nvim-lint: executável '%s' não encontrado (%s)"):format(name, cmd), vim.log.levels.WARN)
		end
	end
	return found
end

local function run(names)
	names = available(names)
	if #names > 0 then
		lint.try_lint(names)
	end
end

local group = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
	group = group,
	pattern = "*.php",
	callback = function()
		run(fast_linters)
	end,
})

-- Um novo try_lint mata o processo anterior do mesmo linter no mesmo buffer.
-- Por isso o phpstan fica fora do InsertLeave: ele seria cancelado antes de
-- terminar toda vez que você saísse do modo de inserção.
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
	group = group,
	pattern = "*.php",
	callback = function()
		run(slow_linters)
	end,
})

vim.keymap.set("n", "<leader>dl", function()
	run(fast_linters)
	run(slow_linters)
end, { desc = "Rodar linters no buffer (phpmd + phpstan)" })
