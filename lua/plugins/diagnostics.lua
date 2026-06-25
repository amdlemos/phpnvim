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
	auto_preview = true,
	max_items = nil,
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
	filters = {
		filename_filter = function(item, value, _)
			if type(value) ~= "table" or vim.tbl_isempty(value) then
				return true
			end
			return value[item.filename] == true
		end,
	},
		modes = {
			lsp_references = {
				mode = "lsp_references",
				preview = {
					type = "main",
				},
				group = function(item)
					return item.filename
				end,
				sort = { { field = "filename" }, { field = "pos" } },
				keys = {
				["/"] = function(view)
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

					vim.cmd.packadd("fzf-lua")
					require("fzf-lua").fzf_exec(filenames, {
						prompt = "Filtrar referências por arquivo> ",
						winopts = { height = 0.4, width = 0.6 },
						actions = {
							["default"] = function(selected)
								if not selected or #selected == 0 then
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

			-- Quickfix mode: avoid grouping so each file is shown only once
			quickfix = {
				mode = "quickfix",
				preview = { type = "main" },
				group = function()
					-- return false to disable grouping/parent nodes so each file appears only once
					return false
				end,
			},
		},

		symbols = {
			desc = "document symbols",
			mode = "lsp_document_symbols",
			focus = false,
			format = "{kind_icon} {symbol.name}",
		},
	},
	win = {
		type = "split",
		position = "bottom",
		height = 15,
		relative = "editor",
		wo = {
			number = false,
			relativenumber = false,
		},
	},
})

local function getEdgyPosition(mode)
	if mode == "symbols" then
		return "left"
	else
		return "bottom"
	end
end

local function trouble_switch(mode, opts)
	local trouble = require("trouble")
	local View = require("trouble.view")
	local desiredPosition = getEdgyPosition(mode)

	for view, _ in pairs(View._views) do
		if view.win:valid() and view.opts.mode ~= mode then
			local viewPosition = getEdgyPosition(view.opts.mode)
			if viewPosition == desiredPosition then
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

vim.keymap.set("n", "<leader>so", function()
	trouble_switch("symbols")
end, { desc = "Símbolos do documento (Trouble - lateral esquerda)" })
