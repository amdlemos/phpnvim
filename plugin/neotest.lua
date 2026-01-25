-- if true then
-- 	return
-- end
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/antoinemadec/FixCursorHold.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
	{ src = "https://github.com/olimorris/neotest-phpunit" },
	{ src = "https://github.com/nvim-neotest/neotest" },
})

require("neotest").setup({
	adapters = {
		(function()
			local adapter = require("neotest-phpunit")({
				phpunit_cmd = function()
					return { "ddev", "exec", "vendor/bin/phpunit" }
				end,
				root_files = { "composer.json" },
			})

			local original_build_spec = adapter.build_spec
			local original_results = adapter.results

			adapter.build_spec = function(args)
				local position = args.tree:data()
				local cwd = vim.loop.cwd() or ""

				local adjusted_path = position.path
				if adjusted_path:find(cwd, 1, true) == 1 then
					adjusted_path = adjusted_path:sub(#cwd + 2)
				end

				if position.type == "dir" then
					adjusted_path = ""
				end

				vim.fn.mkdir(cwd .. "/storage/logs", "p")

				local host_results = cwd .. "/storage/logs/phpunit-junit.xml"
				local container_results = "/var/www/html/storage/logs/phpunit-junit.xml"

				local command = vim.tbl_flatten({
					"ddev",
					"exec",
					"vendor/bin/phpunit",
					adjusted_path ~= "" and adjusted_path or nil,
					"--log-junit=" .. container_results,
					position.type == "test" and { "--filter", position.name } or nil,
				})

				return {
					command = command,
					context = {
						results_path = host_results,
					},
				}
			end

			-- Override results para converter paths do container para host
			adapter.results = function(spec, result, tree)
				local cwd = vim.loop.cwd() or ""
				local container_path = "/var/www/html"

				-- Lê o XML
				local f = io.open(spec.context.results_path, "r")
				if f then
					local content = f:read("*a")
					f:close()

					-- Substitui paths do container por paths do host
					content = content:gsub(container_path, cwd)

					-- Salva o XML modificado
					f = io.open(spec.context.results_path, "w")
					if f then
						f:write(content)
						f:close()
					end
				end

				-- Agora chama a função original com o XML corrigido
				return original_results(spec, result, tree)
			end

			return adapter
		end)(),
	},

	output = {
		enabled = true,
		open_on_run = false,
	},
})
-- Prefixo <leader>t para "test"
vim.keymap.set("n", "<leader>tp", "<cmd>Neotest output-panel toggle<cr>", { desc = "Neotest: Output Panel" })
vim.keymap.set("n", "<leader>ts", "<cmd>Neotest summary toggle<cr>", { desc = "Neotest: Summary" })
vim.keymap.set("n", "<leader>tn", "<cmd>Neotest run<cr>", { desc = "Neotest: Run Nearest" })
vim.keymap.set("n", "<leader>tf", "<cmd>Neotest run file<cr>", { desc = "Neotest: Run File" })
vim.keymap.set("n", "<leader>tl", "<cmd>Neotest run last<cr>", { desc = "Neotest: Run Last" })
-- Configuração do vim-test para Docker (sem neotest)
-- vim.g["test#php#pest#executable"] = "docker compose -f docker-compose.dev.yml exec -T app vendor/bin/pest"
-- vim.g["test#strategy"] = "neovim"
-- vim.g["test#neovim#term_position"] = "botright"
-- vim.g["test#neovim#start_insert"] = 1
