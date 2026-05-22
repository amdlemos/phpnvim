-- Diagnostics Configuration

vim.diagnostic.config({
	virtual_text = false,
	signs = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	underline = {
		severity = { min = vim.diagnostic.severity.WARN },
	},
	update_in_insert = false,
	severity_sort = true,
})

-- Definir ícones na sign column
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require("tiny-inline-diagnostic").setup({
	throttle = 200,
	filter = {
		severity = vim.diagnostic.severity.WARN,
	},
})

vim.keymap.set("n", "<leader>de", "<cmd>TinyInlineDiag enable<cr>", { desc = "Enable diagnostics" })
vim.keymap.set("n", "<leader>dd", "<cmd>TinyInlineDiag disable<cr>", { desc = "Disable diagnostics" })

require("trouble").setup({
	auto_preview = true,  -- Ativar preview automático ao navegar
	max_items = nil,  -- Sem limite de itens
	throttle = {
		refresh = 200,
		update = 100,
		render = 100,
		follow = 200,
	},
	keys = {
		l = "fold_open",
		h = "fold_close",
	},
	-- Configurações para exibir references em uma janela dock
	modes = {
		lsp_references = {
			mode = "lsp_references",
			preview = {
				type = "main",  -- Usa a janela principal para preview
			},
			-- Agrupar por arquivo (filename)
			group = function(item)
				return item.filename
			end,
			-- Ordenar por arquivo e depois por posição (linha/col)
			sort = { { field = "filename" }, { field = "pos" } },
		},
		-- Modo de referências com filtro por nome de arquivo
		lsp_references_filter = {
			mode = "lsp_references",
			preview = {
				type = "main",
			},
			group = function(item)
				return item.filename
			end,
			sort = { { field = "filename" }, { field = "pos" } },
			filter = function(items)
				local pattern = vim.fn.input("Filtrar por arquivo (padrão): ")
				if pattern == "" then
					return items
				end
				return vim.tbl_filter(function(item)
					return item.filename:find(pattern, 1, true) ~= nil
				end, items)
			end,
		},
	},
	win = {
		type = "split",
		position = "bottom",
		height = 15,
		relative = "editor",  -- Relativo ao editor, não à janela
		wo = {
			number = false,
			relativenumber = false,
			winfixheight = true,  -- Fixa a altura para não quebrar ao trocar janelas
		},
	},
})

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Diagnósticos do buffer (Trouble)" })
