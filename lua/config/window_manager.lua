-- Este arquivo contém uma solução robusta para corrigir os problemas de layout
-- entre nvim-tree e dap-ui. Coloque este código em um arquivo separado,
-- por exemplo: ~/.config/nvim/lua/config/window_manager.lua

local M = {}

-- Estado global para controlar as diferentes janelas
M.state = {
	nvim_tree_open = false,
	dapui_open = false,
	dapui_layouts = { left = false, right = false },
	saved_widths = {
		nvim_tree = 30,
		dapui_left = 40,
		dapui_right = 40,
	},
}

-- Encontra o buffer ID do nvim-tree
local function find_nvim_tree_win()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local buf_name = vim.api.nvim_buf_get_name(buf)
		if buf_name:match("NvimTree") then
			return win
		end
	end
	return nil
end

-- Encontra o buffer ID do dapui por posição
local function find_dapui_win(position)
	-- Verifica todas as janelas
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local buf_name = vim.api.nvim_buf_get_name(buf)

		-- DAP UI tem nomes específicos por painel
		if position == "left" and buf_name:match("DAP") and buf_name:match("Breakpoints") then
			return win
		elseif position == "right" and buf_name:match("DAP") and buf_name:match("Scopes") then
			return win
		end
	end
	return nil
end

-- Restaura as larguras corretas para todas as janelas
function M.restore_window_widths()
	-- Pequena pausa para garantir que todos os buffers estejam carregados
	vim.defer_fn(function()
		-- Primeiro restaura a largura do nvim-tree se estiver aberto
		local nvim_tree_win = find_nvim_tree_win()
		if nvim_tree_win and M.state.nvim_tree_open then
			vim.api.nvim_win_set_width(nvim_tree_win, M.state.saved_widths.nvim_tree)
		end

		-- Restaura as larguras dos painéis DAP UI
		local dapui_left_win = find_dapui_win("left")
		if dapui_left_win and M.state.dapui_layouts.left then
			vim.api.nvim_win_set_width(dapui_left_win, M.state.saved_widths.dapui_left)
		end

		local dapui_right_win = find_dapui_win("right")
		if dapui_right_win and M.state.dapui_layouts.right then
			vim.api.nvim_win_set_width(dapui_right_win, M.state.saved_widths.dapui_right)
		end

		-- Força o Neovim a recalcular as janelas
		vim.cmd("redraw")
	end, 100)
end

-- Fecha todos os painéis abertos e redefine o estado
function M.close_all_panels()
	local nvim_tree = require("nvim-tree.api")
	local dapui = require("dapui")

	-- Fecha nvim-tree se estiver aberto
	if M.state.nvim_tree_open then
		nvim_tree.tree.close()
		M.state.nvim_tree_open = false
	end

	-- Fecha os painéis dapui se estiverem abertos
	if M.state.dapui_open then
		dapui.close()
		M.state.dapui_open = false
		M.state.dapui_layouts = { left = false, right = false }
	end

	-- Força o Neovim a recalcular as janelas
	vim.cmd("wincmd =")
	vim.cmd("redraw")
end

-- Abre o nvim-tree com gestão de estado
function M.toggle_nvim_tree()
	local nvim_tree = require("nvim-tree.api")

	if M.state.nvim_tree_open then
		nvim_tree.tree.close()
		M.state.nvim_tree_open = false
	else
		nvim_tree.tree.open()
		M.state.nvim_tree_open = true
	end

	M.restore_window_widths()
end

-- Abre o dapui com gestão de estado
function M.toggle_dapui(layout_number)
	local dapui = require("dapui")

	if not layout_number then
		-- Toggle todos os layouts
		if M.state.dapui_open then
			dapui.close()
			M.state.dapui_open = false
			M.state.dapui_layouts = { left = false, right = false }
		else
			dapui.open()
			M.state.dapui_open = true
			M.state.dapui_layouts = { left = true, right = true }
		end
	else
		-- Toggle apenas o layout específico
		if layout_number == 1 then
			-- Layout esquerdo
			if M.state.dapui_layouts.left then
				dapui.close({ layout = 1 })
				M.state.dapui_layouts.left = false
			else
				dapui.open({ layout = 1 })
				M.state.dapui_layouts.left = true
			end
			M.state.dapui_open = M.state.dapui_layouts.left or M.state.dapui_layouts.right
		elseif layout_number == 2 then
			-- Layout direito (scopes)
			if M.state.dapui_layouts.right then
				dapui.close({ layout = 2 })
				M.state.dapui_layouts.right = false
			else
				dapui.open({ layout = 2 })
				M.state.dapui_layouts.right = true
			end
			M.state.dapui_open = M.state.dapui_layouts.left or M.state.dapui_layouts.right
		end
	end

	M.restore_window_widths()
end

-- Configura o nvim-tree
function M.setup_nvim_tree()
	require("nvim-tree").setup({
		sort = {
			sorter = "case_sensitive",
		},
		view = {
			width = M.state.saved_widths.nvim_tree,
		},
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = false,
		},
		actions = {
			open_file = {
				resize_window = true,
				quit_on_open = false,
			},
		},
		on_attach = function(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- Mapeamentos padrão
			vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
			vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
			vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
			vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
			vim.keymap.set("n", "a", api.fs.create, opts("Create"))
			vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
			vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
			vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
			vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
			vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
			vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
			vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
			vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
			vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
		end,
	})

	-- Eventos para correto redimensionamento
	vim.api.nvim_create_autocmd("User", {
		pattern = "NvimTreeOpen",
		callback = function()
			M.state.nvim_tree_open = true
			M.restore_window_widths()
		end,
	})

	vim.api.nvim_create_autocmd("User", {
		pattern = "NvimTreeClose",
		callback = function()
			M.state.nvim_tree_open = false
			M.restore_window_widths()
		end,
	})

	-- Mapear o toggle
	vim.keymap.set("n", "<leader>e", function()
		M.toggle_nvim_tree()
	end, { desc = "Toggle NvimTree Explorer" })
end

-- Configura o dapui
function M.setup_dapui()
	local dap = require("dap")
	local dapui = require("dapui")

	dapui.setup({
		icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
		mappings = {
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		layouts = {
			{
				elements = {
					{ id = "breakpoints", size = 0.25 },
					{ id = "watches", size = 0.25 },
					{ id = "stacks", size = 0.25 },
				},
				size = M.state.saved_widths.dapui_left / 100,
				position = "left",
			},
			{
				elements = {
					{ id = "scopes", size = 1.0 },
				},
				size = M.state.saved_widths.dapui_right / 100,
				position = "right",
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			border = "single",
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		controls = {
			enabled = true,
		},
		render = {
			max_type_length = nil,
			max_value_lines = 100,
		},
	})

	-- DAP eventos com gestão de estado
	dap.listeners.after.event_initialized["dapui_config"] = function()
		vim.defer_fn(function()
			dapui.open()
			M.state.dapui_open = true
			M.state.dapui_layouts = { left = true, right = true }
			M.restore_window_widths()
		end, 100)
	end

	dap.listeners.before.event_terminated["dapui_config"] = function()
		vim.defer_fn(function()
			dapui.close()
			M.state.dapui_open = false
			M.state.dapui_layouts = { left = false, right = false }
			M.restore_window_widths()
		end, 100)
	end

	dap.listeners.before.event_exited["dapui_config"] = function()
		vim.defer_fn(function()
			dapui.close()
			M.state.dapui_open = false
			M.state.dapui_layouts = { left = false, right = false }
			M.restore_window_widths()
		end, 100)
	end

	-- Atalhos para o dapui
	vim.keymap.set("n", "<leader>du", function()
		M.toggle_dapui()
	end, { desc = "Toggle DAP UI" })

	vim.keymap.set("n", "<leader>ds", function()
		M.toggle_dapui(2) -- Alterna apenas o painel de scopes (lado direito)
	end, { desc = "Toggle DAP Scopes" })

	-- Teclado de emergência - força o fechamento de todos os painéis
	vim.keymap.set("n", "<leader>dC", function()
		M.close_all_panels()
	end, { desc = "Close All Panels (Emergency)" })
end

return M
