-- Core Autocmds
-- Autocomandos globais

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.hl.on_yank({ timeout = 170 })
	end,
	group = highlight_group,
})

-- Auto-reload quando arquivo muda externamente
autocmd({ "FocusGained", "BufEnter" }, {
	command = "checktime",
})

-- Markdown
autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.textwidth = 120
		vim.opt_local.formatoptions:append("t")
		vim.opt_local.colorcolumn = "120"
	end,
})

-- PHP
autocmd("FileType", {
	pattern = "php",
	callback = function()
		vim.opt_local.textwidth = 80
		vim.opt_local.formatoptions:append("t")
		vim.opt_local.colorcolumn = "80"
	end,
})

vim.api.nvim_create_user_command('PackUpdate', function()
  vim.pack.update()
end, {})
