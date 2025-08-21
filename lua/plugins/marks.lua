return {
	"chentoast/marks.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("marks").setup({
			-- Mostrar marcações padrão
			default_mappings = true,

			-- Marcações built-in para incluir
			builtin_marks = { ".", "<", ">", "^" },

			-- Navegação cíclica
			cyclic = true,

			-- Forçar escrita no shada
			force_write_shada = true,

			-- Intervalo de refresh
			refresh_interval = 250,

			-- Prioridade dos sinais
			sign_priority = {
				lower = 10,
				upper = 15,
				builtin = 8,
				bookmark = 20,
			},

			-- Filetypes excluídos
			excluded_filetypes = {
				"qf",
				"NvimTree",
				"toggleterm",
				"TelescopePrompt",
				"alpha",
				"netrw",
				"oil",
			},

			-- Configurações de bookmark
			bookmark_0 = {
				sign = "⚑",
				virt_text = "bookmark",
				annotate = false,
			},
			bookmark_1 = {
				sign = "⚐",
				virt_text = "bookmark 1",
				annotate = false,
			},
			bookmark_2 = {
				sign = "⚑",
				virt_text = "bookmark 2",
				annotate = false,
			},
			bookmark_3 = {
				sign = "⚐",
				virt_text = "bookmark 3",
				annotate = false,
			},
			bookmark_4 = {
				sign = "⚑",
				virt_text = "bookmark 4",
				annotate = false,
			},
			bookmark_5 = {
				sign = "⚐",
				virt_text = "bookmark 5",
				annotate = false,
			},
			bookmark_6 = {
				sign = "⚑",
				virt_text = "bookmark 6",
				annotate = false,
			},
			bookmark_7 = {
				sign = "⚐",
				virt_text = "bookmark 7",
				annotate = false,
			},
			bookmark_8 = {
				sign = "⚑",
				virt_text = "bookmark 8",
				annotate = false,
			},
			bookmark_9 = {
				sign = "⚐",
				virt_text = "bookmark 9",
				annotate = false,
			},

			-- Mapeamentos personalizados
			mappings = {
				-- Marcações de letras
				set = "m",
				delete_line = "dm",
				delete_buf = "dm=",
				next = "m]",
				prev = "m[",

				-- Bookmarks numerados
				set_bookmark0 = "m0",
				set_bookmark1 = "m1",
				set_bookmark2 = "m2",
				set_bookmark3 = "m3",
				set_bookmark4 = "m4",
				set_bookmark5 = "m5",
				set_bookmark6 = "m6",
				set_bookmark7 = "m7",
				set_bookmark8 = "m8",
				set_bookmark9 = "m9",

				-- Deletar bookmarks
				delete_bookmark0 = "dm0",
				delete_bookmark1 = "dm1",
				delete_bookmark2 = "dm2",
				delete_bookmark3 = "dm3",
				delete_bookmark4 = "dm4",
				delete_bookmark5 = "dm5",
				delete_bookmark6 = "dm6",
				delete_bookmark7 = "dm7",
				delete_bookmark8 = "dm8",
				delete_bookmark9 = "dm9",

				-- Navegação em bookmarks
				next_bookmark = "m}",
				prev_bookmark = "m{",
				next_bookmark0 = "m)0",
				next_bookmark1 = "m)1",
				next_bookmark2 = "m)2",
				next_bookmark3 = "m)3",
				next_bookmark4 = "m)4",
				next_bookmark5 = "m)5",
				next_bookmark6 = "m)6",
				next_bookmark7 = "m)7",
				next_bookmark8 = "m)8",
				next_bookmark9 = "m)9",

				prev_bookmark0 = "m(0",
				prev_bookmark1 = "m(1",
				prev_bookmark2 = "m(2",
				prev_bookmark3 = "m(3",
				prev_bookmark4 = "m(4",
				prev_bookmark5 = "m(5",
				prev_bookmark6 = "m(6",
				prev_bookmark7 = "m(7",
				prev_bookmark8 = "m(8",
				prev_bookmark9 = "m(9",
			},
		})

		-- Função personalizada para Telescope marks com preview melhorado
		local function telescope_marks_enhanced()
			local actions = require("telescope.actions")
			local action_state = require("telescope.actions.state")
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local conf = require("telescope.config").values
			local previewers = require("telescope.previewers")

			-- Buscar todas as marcações
			local marks = {}
			local marks_list = vim.fn.getmarklist()

			-- Adicionar marcações do buffer atual
			for _, mark in pairs(vim.fn.getmarklist("%")) do
				local line = vim.api.nvim_buf_get_lines(0, mark.pos[2] - 1, mark.pos[2], false)[1] or ""
				table.insert(marks, {
					mark = mark.mark:sub(2, 2), -- Remove o '
					filename = vim.fn.expand("%:p"),
					lnum = mark.pos[2],
					col = mark.pos[3],
					text = line:gsub("^%s*", ""), -- Remove espaços do início
					bufnr = vim.api.nvim_get_current_buf(),
				})
			end

			-- Adicionar marcações globais
			for _, mark in pairs(marks_list) do
				if mark.file then
					local ok, lines = pcall(vim.fn.readfile, mark.file, "", mark.pos[2])
					local line = ""
					if ok and lines[mark.pos[2]] then
						line = lines[mark.pos[2]]:gsub("^%s*", "")
					end

					table.insert(marks, {
						mark = mark.mark:sub(2, 2),
						filename = mark.file,
						lnum = mark.pos[2],
						col = mark.pos[3],
						text = line,
						bufnr = vim.fn.bufnr(mark.file),
					})
				end
			end

			if #marks == 0 then
				vim.notify("No marks found", vim.log.levels.INFO)
				return
			end

			pickers
				.new({}, {
					prompt_title = "Marks",
					finder = finders.new_table({
						results = marks,
						entry_maker = function(entry)
							return {
								value = entry,
								display = string.format(
									"%-2s %s:%d %s",
									entry.mark,
									vim.fn.fnamemodify(entry.filename, ":t"),
									entry.lnum,
									entry.text
								),
								ordinal = entry.mark .. " " .. entry.filename .. " " .. entry.text,
								filename = entry.filename,
								lnum = entry.lnum,
								col = entry.col,
								bufnr = entry.bufnr,
							}
						end,
					}),
					sorter = conf.generic_sorter({}),
					previewer = previewers.new_buffer_previewer({
						title = "Mark Preview",
						define_preview = function(self, entry, status)
							local lines = vim.fn.readfile(entry.filename)
							local start_line = math.max(1, entry.lnum - 10)
							local end_line = math.min(#lines, entry.lnum + 10)

							local preview_lines = {}
							for i = start_line, end_line do
								local prefix = i == entry.lnum and ">>> " or "    "
								table.insert(preview_lines, prefix .. (lines[i] or ""))
							end

							vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, preview_lines)

							-- Highlight da linha da marcação
							local highlight_line = entry.lnum - start_line + 1
							if highlight_line >= 1 and highlight_line <= #preview_lines then
								vim.api.nvim_buf_add_highlight(
									self.state.bufnr,
									-1,
									"Search",
									highlight_line - 1,
									0,
									-1
								)
							end
						end,
					}),
					attach_mappings = function(prompt_bufnr, map)
						local function go_to_mark()
							local selection = action_state.get_selected_entry()
							actions.close(prompt_bufnr)

							vim.cmd("edit " .. selection.filename)
							vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col })
							vim.cmd("normal! zz")
						end

						local function go_to_mark_split()
							local selection = action_state.get_selected_entry()
							actions.close(prompt_bufnr)

							vim.cmd("split " .. selection.filename)
							vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col })
							vim.cmd("normal! zz")
						end

						local function go_to_mark_vsplit()
							local selection = action_state.get_selected_entry()
							actions.close(prompt_bufnr)

							vim.cmd("vsplit " .. selection.filename)
							vim.api.nvim_win_set_cursor(0, { selection.lnum, selection.col })
							vim.cmd("normal! zz")
						end

						map("i", "<CR>", go_to_mark)
						map("n", "<CR>", go_to_mark)
						map("i", "<C-x>", go_to_mark_split)
						map("n", "<C-x>", go_to_mark_split)
						map("i", "<C-v>", go_to_mark_vsplit)
						map("n", "<C-v>", go_to_mark_vsplit)

						return true
					end,
				})
				:find()
		end

		-- Keymaps
		vim.keymap.set("n", "<leader>sm", telescope_marks_enhanced, { desc = "Search marks" })
		vim.keymap.set("n", "<leader>ma", function()
			require("telescope.builtin").marks()
		end, { desc = "Marks (built-in telescope)" })

		-- Keymaps para navegação rápida
		vim.keymap.set("n", "<leader>m1", function()
			vim.cmd("normal! `1")
		end, { desc = "Go to mark 1" })
		vim.keymap.set("n", "<leader>m2", function()
			vim.cmd("normal! `2")
		end, { desc = "Go to mark 2" })
		vim.keymap.set("n", "<leader>m3", function()
			vim.cmd("normal! `3")
		end, { desc = "Go to mark 3" })
		vim.keymap.set("n", "<leader>m4", function()
			vim.cmd("normal! `4")
		end, { desc = "Go to mark 4" })
		vim.keymap.set("n", "<leader>m5", function()
			vim.cmd("normal! `5")
		end, { desc = "Go to mark 5" })

		-- Mostrar todas as marcações
		vim.keymap.set("n", "<leader>ml", function()
			vim.cmd("marks")
		end, { desc = "List all marks" })
	end,
}
