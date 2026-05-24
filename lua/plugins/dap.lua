-- DAP (Debug Adapter Protocol) Configuration

local dapui_ok, dapui = pcall(require, "dapui")
local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	return
end

-- Ícones para DAP
vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DapBreakpoint", linehl = "", numhl = "" })
vim.fn.sign_define(
	"DapStopped",
	{ text = " ", texthl = "DapStopped", linehl = "DebugStopped", numhl = "DebugStopped" }
)
vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DapBreakpoint", linehl = "", numhl = "" })

-- Configuração do adaptador PHP
dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { "/home/amdlemos/.config/vscode-php-debug/out/phpDebug.js" },
	options = {
		cwd = vim.fn.getcwd(),
	},
}

-- dap.configurations.php = {
-- 	{
-- 		type = "php",
-- 		request = "launch",
-- 		name = "Listen for Xdebug",
-- 		port = 9003,
-- 		pathMappings = {
-- 			["/var/www/html/web"] = "/home/amdlemos/github/sistema-vexor",
-- 		},
-- 	},
-- }

-- Configuração do adaptador Dart
dap.adapters.dart = {
	type = "executable",
	command = "flutter",
	args = { "debug_adapter" },
}

dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch Flutter Program",
		program = "${file}",
		cwd = "${workspaceFolder}",
		toolArgs = { "-d", "linux" },
	},
}

if dapui_ok then
	dapui.setup({
		layouts = {
			{
				elements = {
					{ id = "watches", size = 0.5 },
					-- { id = "repl", size = 0.5 },
					{ id = "breakpoints", size = 0.5 },
				},
				position = "right",
				size = 40,
			},
		},
	})

	-- Open/close dapui automatically when DAP starts/closes
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.disconnect["dapui_config"] = function()
		dapui.close()
	end

	-- Sincronizar breakpoints quando deletados no dapui
	-- Listener para quando o breakpoint é removido no UI
	dapui.elements.breakpoints.on_element_delete = function(breakpoint)
		if breakpoint and breakpoint.file then
			-- Remover breakpoint do DAP
			dap.clear_breakpoints({ file = breakpoint.file, line = breakpoint.line })
		end
	end
end

-- Keymaps
local keymap = vim.keymap.set
local s = { silent = true }

-- which-key: registrar grupo e descrições (se disponível)
do
	local wk_ok, wk = pcall(require, "which-key")
	if wk_ok then
		if wk.add then
			wk.add({
				{ "<leader>d", group = "DAP/Debug" },
				{ "<leader>db", desc = "DAP Toggle Breakpoint" },
				{ "<leader>dc", desc = "DAP Continue" },
				{ "<leader>do", desc = "DAP Step Over" },
				{ "<leader>di", desc = "DAP Step Into" },
				{ "<leader>dk", desc = "DAP Hover" },
				{ "<leader>dt", desc = "DAP Toggle Panel" },
			})
		end
	end
end

-- DAP breakpoints e debug
keymap("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, vim.tbl_extend("force", s, { desc = "DAP Toggle Breakpoint" }))
keymap("n", "<leader>dB", function()
	dap.clear_breakpoints()
	print("Todos os breakpoints removidos")
end, vim.tbl_extend("force", s, { desc = "DAP Clear All Breakpoints" }))
keymap("n", "<leader>dc", function()
	dap.continue()
end, vim.tbl_extend("force", s, { desc = "DAP Continue" }))
keymap("n", "<F10>", function()
	dap.step_over()
end, vim.tbl_extend("force", s, { desc = "DAP Step Over" }))
keymap("n", "<leader>di", function()
	dap.step_into()
end, vim.tbl_extend("force", s, { desc = "DAP Step Into" }))
keymap("n", "<leader>dk", function()
	require("dap.ui.widgets").hover()
end, vim.tbl_extend("force", s, { desc = "DAP Hover" }))

-- Toggle dap-ui panel (leader dt)
keymap("n", "<leader>dt", function()
	if not dapui_ok then
		return
	end

	-- Prefer dapui.toggle if available
	if dapui.toggle then
		dapui.toggle()
		return
	end

	-- Fallback: detect any open dapui buffer by name and open/close accordingly
	local open = false
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.api.nvim_buf_get_name(buf)
		if name:match("dapui_") then
			open = true
			break
		end
	end

	if open then
		dapui.close()
	else
		dapui.open()
	end
end, vim.tbl_extend("force", s, { desc = "DAP Toggle Panel" }))

-- Fechar floats do DAP com 'q'
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "dap-float", "dapui_watches", "dapui_scopes", "dapui_hover" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close!<CR>", { buffer = true, silent = true })
	end,
})

-- Remover breakpoint no dapui e sincronizar com DAP
vim.api.nvim_create_autocmd("FileType", {
	pattern = "dapui_breakpoints",
	callback = function()
		vim.keymap.set("n", "d", function()
			-- Pegar a linha atual (primeira coluna é o arquivo)
			local line = vim.api.nvim_get_current_line()
			-- Tentar extrair arquivo:linha do breakpoint
			local file, lnum = line:match("([^:]+):(%d+)")
			if file and lnum then
				lnum = tonumber(lnum)
				-- Remover todos os breakpoints desse arquivo/linha
				dap.set_breakpoint(nil, nil, nil, { file = file, line = lnum })
			end
			-- Recarregar o dapui
			if dapui_ok and dapui.open then
				dapui.open()
			end
		end, { buffer = true, silent = true, desc = "Deletar breakpoint" })
	end,
})
