-- local icons = require("plugins.lib.icons")
return {
	{
		"mfussenegger/nvim-dap",
		-- dependencies = {
		--   { "igorlfs/nvim-dap-view", opts = {} },
		-- },
		enabled = true,
		config = function()
			local dap = require("dap")

			-- Configuração do adaptador PHP com logs
			dap.adapters.php = {
				type = "executable",
				command = "node",
				args = { "/home/amdlemos/.config/vscode-php-debug/out/phpDebug.js" },
				options = {
					cwd = vim.fn.getcwd(),
				},
			}
		end,
		keys = {
			{
				"<leader>d",
				"",
				desc = "Debug",
			},
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Over",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Into",
			},
			{
				"<leader>dk",
				function()
					require("dap.ui.widgets").hover()
				end,
				desc = "Open value of expressio",
			},
			{
				"<leader>ds",
				function()
					local widgets = require("dap.ui.widgets")
					local my_sidebar = widgets.sidebar(widgets.scopes)
					local winopts = { width = 300 }
					my_sidebar.open(winopts)
				end,
				desc = "View the current scopes in a sidebar",
			},
			{
				"<leader>df",
				function()
					local widgets = require("dap.ui.widgets")
					local my_sidebar = widgets.sidebar(widgets.frames)
					local winopts = { width = 300 }
					my_sidebar.open(winopts)
				end,
				desc = "View the current frames in a sidebar",
			},
			-- {
			--   "<leader>do",
			--   function()
			--     require("dapui").open()
			--   end,
			--   desc = "Open DAP UI",
			-- },
		},
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			dapui.setup({
				layouts = {
					{
						elements = {
							{
								id = "scopes",
								size = 0.70,
							},

							{
								id = "breakpoints",
								size = 0.15,
							},
							{
								id = "console",
								size = 0.15,
							},
							-- {
							-- 	id = "stacks",
							-- 	size = 0.25,
							-- },
							-- {
							-- 	id = "watches",
							-- 	size = 0.25,
							-- },
						},
						position = "right",
						size = 75,
					},
					{
						elements = {

							{
								id = "repl",
								size = 1,
							},
						},
						position = "bottom",
						size = 15,
					},
				},
			})
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
		end,
	},
}
