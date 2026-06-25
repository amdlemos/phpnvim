-- Telescope Configuration
-- Fuzzy finder principal: arquivos, buffers, grep, LSP, git

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local map = vim.keymap.set

telescope.setup({
	defaults = {
		prompt_prefix = "  ",
		selection_caret = "→ ",
		entry_prefix = "  ",
		sorting_strategy = "ascending",
		path_display = {"filename_first"},
		layout_config = {
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
			},
			width = 0.87,
			height = 0.80,
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
                ["<C-q>"] = function(prompt_bufnr)
                    actions.send_to_qflist(prompt_bufnr)
                    local ok, trouble = pcall(require, "trouble")
                    vim.defer_fn(function()
                        -- Deduplicate quickfix by filename: keep first occurrence per file
                        local qfl = vim.fn.getqflist()
                        local seen = {}
                        local items = {}
                        for _, it in ipairs(qfl) do
                            local fname = it.filename or (it.bufnr and vim.fn.bufname(it.bufnr)) or nil
                            if fname and fname ~= "" and not seen[fname] then
                                seen[fname] = true
                                local bufnr = vim.fn.bufnr(fname, true)
                                if bufnr == -1 or bufnr == 0 then
                                    bufnr = vim.fn.bufadd(fname)
                                    vim.fn.bufload(bufnr)
                                end
                                local l = it.lnum or 1
                                local c = it.col or 1
                                table.insert(items, {
                                    bufnr = bufnr,
                                    lnum = l,
                                    col = c,
                                    text = vim.fn.fnamemodify(fname, ':t') .. " [" .. l .. "," .. c .. "]",
                                })
                            end
                        end
                        if #items > 0 then
                            vim.fn.setqflist({}, 'r', { items = items })
                        end

                        if ok and trouble and type(trouble.open) == "function" then
                            pcall(trouble.open, { mode = "quickfix" })
                        else
                            actions.open_qflist(prompt_bufnr)
                        end
                    end, 80)
                end,
				["<Esc>"] = actions.close,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		["ui-select"] = {
			require("telescope.themes").get_dropdown(),
		},
	},
})

-- Extensões (pcall para não quebrar se não estiver compilado)
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "ui-select")

-- Arquivos e buffers
map("n", "<leader>ff", builtin.find_files, { desc = "Arquivos (projeto)" })
map("n", "<leader>fa", function()
	builtin.find_files({ cwd = vim.fn.expand("~"), hidden = true })
end, { desc = "Todos os arquivos" })
map("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>fr", builtin.oldfiles, { desc = "Arquivos recentes" })

-- Grep / busca
map("n", "<leader>/", function()
	builtin.live_grep({
		additional_args = { "--glob", "!*.json", "--glob", "!*.csv" },
	})
end, { desc = "Live Grep" })
map("n", "<leader>fg", function()
	builtin.live_grep({
		additional_args = { "--glob", "!*.json", "--glob", "!*.csv" },
	})
end, { desc = "Live Grep" })
map("n", "<leader>fw", builtin.grep_string, { desc = "Grep word sob cursor" })

-- Git
map("n", "<leader>gf", builtin.git_files, { desc = "Git Files" })
map("n", "<leader>gs", builtin.git_status, { desc = "Git Status" })
map("n", "<leader>gl", builtin.git_commits, { desc = "Git Log (projeto)" })
map("n", "<leader>gL", builtin.git_bcommits, { desc = "Git Log (arquivo)" })

-- LSP
map("n", "<leader>ld", builtin.lsp_definitions, { desc = "Definições" })
map("n", "<leader>lr", builtin.lsp_references, { desc = "Referências" })
map("n", "<leader>li", builtin.lsp_implementations, { desc = "Implementações" })
map("n", "<leader>lt", builtin.lsp_type_definitions, { desc = "Definições de tipo" })
map("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "Símbolos do documento" })
map("n", "<leader>lS", builtin.lsp_workspace_symbols, { desc = "Símbolos do workspace" })

-- Miscelânea
map("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>fc", builtin.commands, { desc = "Comandos" })
map("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnósticos" })

-- Preview do quickfix: abre/atualiza a janela de preview ao navegar no buffer qf
local function qf_preview()
    if vim.bo.filetype ~= "qf" then
        return
    end

    -- If Trouble is open in quickfix mode, let Trouble handle previews
    local ok_view, View = pcall(require, "trouble.view")
    if ok_view and View and type(View._views) == "table" then
        for view, _ in pairs(View._views) do
            if view.win and view.win:valid() and view.opts and view.opts.mode == "quickfix" then
                return
            end
        end
    end

    local line = vim.api.nvim_win_get_cursor(0)[1]
    local qfl = vim.fn.getqflist()
    local item = qfl[line]
    if not item then
        return
    end

    local filename = item.filename or (item.bufnr and vim.fn.bufname(item.bufnr)) or nil
    if not filename or filename == "" then
        return
    end

    local lnum = item.lnum or 1
    local qf_win = vim.api.nvim_get_current_win()

    local function find_target_win_for_buf(bufnr)
        for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if w ~= qf_win then
                if vim.api.nvim_win_get_buf(w) == bufnr then
                    return w
                end
            end
        end
        return nil
    end

    local bufnr_existing = vim.fn.bufnr(filename)
    local target_win = nil

    if bufnr_existing > 0 then
        target_win = find_target_win_for_buf(bufnr_existing)
    end

    if not target_win then
        for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if w ~= qf_win then
                local b = vim.api.nvim_win_get_buf(w)
                local ft = vim.api.nvim_buf_get_option(b, "filetype")
                if ft ~= "qf" then
                    target_win = w
                    break
                end
            end
        end
    end

    if not (target_win and vim.api.nvim_win_is_valid(target_win)) then
        vim.cmd("rightbelow vsplit")
        target_win = vim.api.nvim_get_current_win()
    end

    vim.b.qf_preview_win = target_win

    local bufnr = bufnr_existing
    if bufnr == -1 or bufnr == 0 then
        bufnr = vim.fn.bufadd(filename)
    end
    vim.fn.bufload(bufnr)

    vim.api.nvim_win_set_buf(target_win, bufnr)
    vim.api.nvim_win_set_cursor(target_win, {lnum, (item.col and (item.col - 1)) or 0})
    vim.api.nvim_set_current_win(qf_win)
end

local augroup = vim.api.nvim_create_augroup("QuickfixPreview", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "qf",
    callback = function()
        vim.opt_local.cursorline = true
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufEnter" }, {
            buffer = 0,
            callback = qf_preview,
        })
        vim.schedule(qf_preview)
    end,
})
