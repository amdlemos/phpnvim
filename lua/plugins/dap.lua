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
			-- PHP

			-- Debug logger
			local function debug_config()
				-- print("DAP Configurations:")
				-- print(vim.inspect(dap.configurations))
				-- print("\nPHP Configurations:")
				-- print(vim.inspect(dap.configurations.php))
			end

			-- Configuração do adaptador PHP com logs
			dap.adapters.php = {
				type = "executable",
				command = "node",
				args = { "/home/amdlemos/.config/vscode-php-debug/out/phpDebug.js" },
				options = {
					cwd = vim.fn.getcwd(),
				},
			}

			-- Função para carregar configurações do VSCode com logs detalhados
			local function load_vscode_config()
				local current_dir = vim.fn.getcwd()
				local vscode_config = current_dir .. "/.vscode/launch.json"

				-- print("Tentando carregar configurações de: " .. vscode_config)

				local file = io.open(vscode_config, "r")
				if not file then
					-- print("Erro: Arquivo launch.json não encontrado")
					return
				end

				local content = file:read("*all")
				file:close()

				local ok, config = pcall(vim.fn.json_decode, content)
				if not ok then
					-- print("Erro ao decodificar JSON: " .. vim.inspect(config))
					return
				end

				if config and config.configurations then
					dap.configurations.php = {}
					for _, conf in ipairs(config.configurations) do
						if conf.type == "php" then
							-- print("Adicionando configuração PHP: " .. vim.inspect(conf))
							table.insert(dap.configurations.php, conf)
						end
					end
				end

				debug_config()
			end

			-- Comandos para diagnóstico
			vim.api.nvim_create_user_command("DebugDapConfig", debug_config, {})
			vim.api.nvim_create_user_command("ReloadDebugConfig", load_vscode_config, {})

			-- Carrega configurações ao iniciar
			vim.api.nvim_create_autocmd({ "VimEnter" }, {
				callback = function()
					load_vscode_config()
				end,
			})

			-- JavaScript
			local JS_DEBUG_PATH = "/home/amdlemos/.config/js-debug/src/dapDebugServer.js"

			local FIREFOX_DEBUG_PATH = "/home/amdlemos/.config/vscode-firefox-debug/dist/adapter.bundle.js"

			-- Configuração do adaptador Chrome
			dap.adapters["pwa-chrome"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						JS_DEBUG_PATH,
						"${port}",
					},
				},
			}
			-- dap.adapters["firefox"] = {
			--   type = "executable",
			--   command = "node",
			--   args = {
			--     FIREFOX_DEBUG_PATH,
			--   },
			-- }

			-- -- Configuração do adaptador Node
			-- dap.adapters["pwa-node"] = {
			--   type = "server",
			--   host = "localhost",
			--   port = "${port}",
			--   executable = {
			--     command = "node",
			--     args = {
			--       JS_DEBUG_PATH,
			--       "${port}",
			--     },
			--   },
			-- }

			-- Configurações para ReactJS
			dap.configurations.javascript = {
				-- Debug React com Chrome
				{
					type = "pwa-chrome",
					name = "Debug React (Chrome)",
					request = "launch",
					url = "http://localhost", -- URL do seu app React
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
					protocol = "inspector",
					port = 9222, -- Porta do Chrome Debug
					skipFiles = { "<node_internals>/**", "**/node_modules/**" },
				},
				-- {
				--   name = "Debug with Firefox",
				--   type = "firefox",
				--   request = "launch",
				--   reAttach = true,
				--   url = "http://localhost",
				--   webRoot = "${workspaceFolder}",
				--   firefoxExecutable = "/usr/bin/firefox",
				--   args = "-start-debugger-server",
				-- },
				-- {
				--   name = "Attach Firefox",
				--   type = "firefox",
				--   request = "attach",
				--   reAttach = true,
				--   host = "127.0.0.1",
				--   ur = "http://localhost",
				--   webRoo = "${workspaceFolder}",
				-- },
				-- -- Attach ao Chrome (para debug de app já em execução)
				-- {
				--   type = "pwa-chrome",
				--   name = "Attach to Chrome",
				--   request = "attach",
				--   port = 9222,
				--   webRoot = "${workspaceFolder}",
				--   sourceMaps = true,
				--   protocol = "inspector",
				--   skipFiles = { "<node_internals>/**", "**/node_modules/**" },
				-- },
				-- -- Debug de Node.js
				-- {
				--   type = "pwa-node",
				--   request = "launch",
				--   name = "Launch Node.js",
				--   program = "${file}",
				--   cwd = "${workspaceFolder}",
				--   sourceMaps = true,
				--   protocol = "inspector",
				--   console = "integratedTerminal",
				--   skipFiles = { "<node_internals>/**", "**/node_modules/**" },
				-- },
				-- -- Debug de Node.js com npm script
				-- {
				--   type = "pwa-node",
				--   request = "launch",
				--   name = "Launch npm script",
				--   runtimeExecutable = "npm",
				--   runtimeArgs = {
				--     "run-script",
				--     "${command:PickProcess}", -- Permite escolher o script do package.json
				--   },
				--   rootPath = "${workspaceFolder}",
				--   cwd = "${workspaceFolder}",
				--   console = "integratedTerminal",
				--   sourceMaps = true,
				--   protocol = "inspector",
				--   skipFiles = { "<node_internals>/**", "**/node_modules/**" },
				-- },
				-- -- Attach ao processo Node.js
				-- {
				--   type = "pwa-node",
				--   request = "attach",
				--   name = "Attach to Node Process",
				--   processId = require("dap.utils").pick_process,
				--   cwd = "${workspaceFolder}",
				--   sourceMaps = true,
				--   skipFiles = { "<node_internals>/**", "**/node_modules/**" },
				-- },
			}

			-- Copia as configurações para javascript e javascriptreact
			dap.configurations.javascriptreact = dap.configurations.javascript
			dap.configurations.typescriptreact = dap.configurations.javascript
			dap.configurations.typescript = dap.configurations.javascript

			-- Configuração do adaptador Ruby para conectar ao debugger em execução
			dap.adapters.ruby = {
				type = "server",
				host = "127.0.0.1",
				port = 38698,
			}

			-- Configuração para debug
			dap.configurations.ruby = {
				{
					type = "ruby",
					name = "Rails Debug",
					request = "attach",
					port = 38698,
					localfs = true,
					cwd = "${workspaceFolder}",
				},
			}

			vim.fn.sign_define("DapBreakpoint", {
				-- text = icons.ui.Bug,
				texthl = "DiagnosticSignError",
				linehl = "",
				numhl = "",
			})
			vim.fn.sign_define("DapStopped", {
				-- text = icons.ui.ArrowRight,
				texthl = "DiagnosticSignWarn",
				linehl = "Visual",
				numhl = "DiagnosticWarn",
			})
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
		-- "rcarriga/nvim-dap-ui",
		-- dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		-- config = function()
		--   require("dapui").setup()
		--   local dap, dapui = require("dap"), require("dapui")
		--   dap.listeners.before.attach.dapui_config = function()
		--     dapui.open()
		--   end
		--   dap.listeners.before.launch.dapui_config = function()
		--     dapui.open()
		--   end
		--   dap.listeners.before.event_terminated.dapui_config = function()
		--     dapui.close()
		--   end
		--   dap.listeners.before.event_exited.dapui_config = function()
		--     dapui.close()
		--   end
		-- end,
	},
}
