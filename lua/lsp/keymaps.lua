-- LSP Keymaps Globais
-- Keymaps globais para diagnósticos (sempre disponíveis)

local keymap = vim.keymap.set

-- Grupo de keymaps para diagnósticos
keymap("n", "<leader>d", "", { desc = "Diagnósticos" })
keymap("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Mostrar diagnóstico", silent = true })
keymap("n", "<leader>da", vim.diagnostic.setqflist, { desc = "Todos os diagnósticos", silent = true })
keymap("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Próximo diagnóstico", silent = true })
keymap("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Diagnóstico anterior", silent = true })

-- Configurar aparência dos diagnósticos
-- vim.diagnostic.config({
-- 	virtual_text = {
-- 		prefix = "●",
-- 		source = "if_many",
-- 	},
-- 	float = {
-- 		source = "always",
-- 		border = "rounded",
-- 	},
-- 	signs = true,
-- 	underline = true,
-- 	update_in_insert = false,
-- 	severity_sort = true,
-- })

-- Ícones para diagnósticos
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
