local ok, dap = pcall(require, "dap")
if not ok then
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

-- Opcional: agrupar atalhos no which-key, se disponível
pcall(function()
	require("which-key").add({ { "<leader>d", group = "Debug" } })
end)

local map = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
end

map("<leader>db", function()
	dap.toggle_breakpoint()
end, "Toggle breakpoint")

map("<leader>dc", function()
	dap.continue()
end, "Continue")

map("<leader>do", function()
	dap.step_over()
end, "Over")

map("<leader>di", function()
	dap.step_into()
end, "Into")

map("<leader>dk", function()
	require("dap.ui.widgets").hover()
end, "Open expression value")

map("<leader>ds", function()
	local widgets = require("dap.ui.widgets")
	local my_sidebar = widgets.sidebar(widgets.scopes)
	local winopts = { width = 300 }
	my_sidebar.open(winopts)
end, "View current scopes in a sidebar")

map("<leader>df", function()
	local widgets = require("dap.ui.widgets")
	local my_sidebar = widgets.sidebar(widgets.frames)
	local winopts = { width = 300 }
	my_sidebar.open(winopts)
end, "View current frames in a sidebar")
