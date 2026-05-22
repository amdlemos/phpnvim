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
	-- Filtro customizado por filename (populado dinamicamente)
	filters = {
		filename_filter = function(item, value, _)
			if type(value) ~= "table" or vim.tbl_isempty(value) then
				return true
			end
			return value[item.filename] == true
		end,
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
			keys = {
				-- Filtrar por nome de arquivo com / usando fzf-lua (multiselect)
				["/"] = function(view)
					-- Coletar filenames únicos dos itens atuais (sem filtro aplicado)
					local seen = {}
					local filenames = {}
					for _, section in ipairs(view.sections or {}) do
						for _, item in ipairs(section.items or {}) do
							if item.filename and not seen[item.filename] then
								seen[item.filename] = true
								filenames[#filenames + 1] = item.filename
							end
						end
					end
					if #filenames == 0 then return end

					-- Abrir fzf-lua com os arquivos únicos para seleção
					vim.cmd.packadd("fzf-lua")
					require("fzf-lua").fzf_exec(filenames, {
						prompt = "Filtrar referências por arquivo> ",
						winopts = { height = 0.4, width = 0.6 },
						actions = {
							["default"] = function(selected)
								if not selected or #selected == 0 then
									-- Sem seleção: remover filtro
									view:filter({ filename_filter = {} }, { id = "filename_filter", del = true })
									return
								end
								local selected_set = {}
								for _, f in ipairs(selected) do
									selected_set[f] = true
								end
								view:filter({ filename_filter = selected_set }, {
									id = "filename_filter",
									template = "",
								})
							end,
						},
					})
				end,
			},
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
