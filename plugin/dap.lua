local dapuiok, dapui = pcall(require, "dapui")
local ok, dap = pcall(require, "dap")
-- if not ok then
-- 	return
-- end

-- Configuração do adaptador PHP
dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { "/home/amdlemos/.config/vscode-php-debug/out/phpDebug.js" },
	options = {
		cwd = vim.fn.getcwd(),
	},
}

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

local keymap = vim.keymap.set
local s = { silent = true }

-- DAP breakpoints e debug
keymap("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, s)
keymap("n", "<leader>dc", function()
	dap.continue()
end, s)
keymap("n", "<leader>do", function()
	dap.step_over()
end, s)
keymap("n", "<leader>di", function()
	dap.step_into()
end, s)
keymap("n", "<leader>dk", function()
	require("dap.ui.widgets").hover()
end, s)
