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
	auto_preview = true, -- Ativar preview automático ao navegar
	max_items = nil, -- Sem limite de itens
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
				type = "main", -- Usa a janela principal para preview
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
					if #filenames == 0 then
						return
					end

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

		-- Modo symbols customizado: mostra apenas ícone e nome do símbolo (sem assinatura/pos)
		symbols = {
			desc = "document symbols",
			mode = "lsp_document_symbols",
			focus = false,
			format = "{kind_icon} {symbol.name}",
			win = { position = "right" },
		},
	},
	win = {
		type = "split",
		position = "bottom",
		height = 15,
		relative = "editor", -- Relativo ao editor, não à janela
		wo = {
			number = false,
			relativenumber = false,
			winfixheight = true, -- Fixa a altura para não quebrar ao trocar janelas
		},
	},
})

local function trouble_switch(mode, opts)
	local trouble = require("trouble")
	local View = require("trouble.view")

	-- Fechar apenas views de outros modos que estejam na mesma posição de janela
	local default_position = "bottom"
	local desired_position
	if opts and opts.win and opts.win.position then
		desired_position = opts.win.position
	elseif mode == "diagnostics" or mode == "lsp_references" then
		desired_position = default_position
	else
		desired_position = nil
	end

	for view, _ in pairs(View._views) do
		if view.win:valid() and view.opts.mode ~= mode then
			local view_pos = (view.opts and view.opts.win and view.opts.win.position) or default_position
			if desired_position and view_pos == desired_position then
				view:close()
			end
		end
	end

	trouble.toggle(vim.tbl_extend("force", { mode = mode }, opts or {}))
end

vim.keymap.set("n", "<leader>xx", function()
	trouble_switch("diagnostics", { filter = { buf = 0 } })
end, { desc = "Diagnósticos do buffer (Trouble)" })

vim.keymap.set("n", "<leader>xr", function()
	trouble_switch("lsp_references")
end, { desc = "Referências (Trouble)" })

-- Abrir símbolos do documento através do Trouble posicionando a janela à esquerda
-- Usa o modo customizado "symbols" para aplicar o formato reduzido
vim.keymap.set("n", "<leader>so", function()
	trouble_switch("symbols", {
		win = {
			type = "split",
			position = "left",
			width = 40,
			relative = "editor",
			wo = {
				number = false,
				relativenumber = false,
				winfixwidth = true,
			},
		},
	})
end, { desc = "Símbolos do documento (Trouble - lateral esquerda)" })
