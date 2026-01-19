vim.pack.add({
	-- DAP
	{ src = "https://github.com/folke/lazydev.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-dap" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/rcarriga/nvim-dap-ui" },
})

local dapui_ok, dapui = pcall(require, "dapui")
local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	return
end

-- Configuração do adaptador PHP
dap.adapters.php = {
	type = "executable",
	command = "node",
	args = { "/home/amdlemos/.config/vscode-php-debug/out/phpDebug.js" },
	options = {
		cwd = vim.fn.getcwd(),
	},
}

dap.configurations.php = {
	{
		type = "php",
		request = "launch",
		name = "Listen for Xdebug",
		port = 9003,
		pathMappings = {
			["/var/www/html/web"] = "/home/amdlemos/github/sistema-vexor"
			-- ["/home/amdlemos/github/runy.me"] = "/var/www/html",
		},
	},
}

dap.adapters.dart = {
	type = "executable",
	-- As of this writing, this functionality is open for review in https://github.com/flutter/flutter/pull/91802
	command = "flutter",
	args = { "debug_adapter" },
}
dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch Flutter Program",
		-- The nvim-dap plugin populates this variable with the filename of the current buffer
		program = "${file}",
		-- The nvim-dap plugin populates this variable with the editor's current working directory
		cwd = "${workspaceFolder}",
		-- This gets forwarded to the Flutter CLI tool, substitute `linux` for whatever device you wish to launch
		toolArgs = { "-d", "linux" },
	},
}
if dapui_ok then
	dapui.setup({
		layouts = {
			{
				elements = {
					-- Painéis úteis na barra lateral esquerda
					{ id = "scopes", size = 0.4 },
					{ id = "breakpoints", size = 0.3 },
					{ id = "stacks", size = 0.3 },
				},
				size = 40,
				position = "left",
			},
			-- {
			-- 	elements = {
			-- 		-- Apenas watches na parte inferior (sem repl e console)
			-- 		{ id = "watches", size = 1.0 },
			-- 	},
			-- 	size = 10,
			-- 	position = "bottom",
			-- },
		},
		controls = {
			enabled = true,
			element = "scopes",
		},
		floating = {
			max_height = nil,
			max_width = nil,
			border = "rounded",
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
	})

	-- Abrir UI ao iniciar a sessão
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	-- Fechar UI ao terminar/sair/desconectar
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.disconnect["dapui_config"] = function()
		dapui.close()
	end
end

local keymap = vim.keymap.set
local s = { silent = true }

-- which-key: registrar grupo e descrições (se disponível)
do
	local wk_ok, wk = pcall(require, "which-key")
	if wk_ok then
		if not wk.add then
			return
		end
		wk.add({
			{ "<leader>d", group = "DAP/Debug" },
			{ "<leader>db", desc = "DAP Toggle Breakpoint" },
			{ "<leader>dc", desc = "DAP Continue" },
			{ "<leader>do", desc = "DAP Step Over" },
			{ "<leader>di", desc = "DAP Step Into" },
			{ "<leader>dk", desc = "DAP Hover" },
		})
	end
end

-- DAP breakpoints e debug
keymap("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, vim.tbl_extend("force", s, { desc = "DAP Toggle Breakpoint" }))
keymap("n", "<leader>dc", function()
	dap.continue()
end, vim.tbl_extend("force", s, { desc = "DAP Continue" }))
keymap("n", "<leader>do", function()
	dap.step_over()
end, vim.tbl_extend("force", s, { desc = "DAP Step Over" }))
keymap("n", "<leader>di", function()
	dap.step_into()
end, vim.tbl_extend("force", s, { desc = "DAP Step Into" }))
keymap("n", "<leader>dk", function()
	require("dap.ui.widgets").hover()
end, vim.tbl_extend("force", s, { desc = "DAP Hover" }))

-- Fechar floats do DAP com 'q'
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "dap-float", "dapui_watches", "dapui_scopes", "dapui_hover" },
	callback = function()
		vim.keymap.set("n", "q", "<cmd>close!<CR>", { buffer = true, silent = true })
	end,
})
