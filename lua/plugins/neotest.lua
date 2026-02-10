-- Neotest Configuration
-- Suporta Sail, DDEV e PHPUnit local com detecção automática

local function get_runner_config()
	local cwd = vim.loop.cwd() or ""
	local runner = "phpunit"

	-- 1. Check for local config file .neotest.lua
	local local_config = cwd .. "/.neotest.lua"
	if vim.fn.filereadable(local_config) == 1 then
		local ok, result = pcall(dofile, local_config)
		if ok and type(result) == "string" then
			runner = result
		end
	-- 2. Check for global override
	elseif vim.g.php_test_runner then
		runner = vim.g.php_test_runner
	-- 3. Heuristics
	elseif vim.fn.isdirectory(cwd .. "/.ddev") == 1 then
		runner = "ddev"
	elseif vim.fn.filereadable(cwd .. "/vendor/bin/sail") == 1 then
		runner = "sail"
	end

	local configs = {
		sail = {
			cmd = { "vendor/bin/sail", "test" },
			container_path = "/var/www/html",
		},
		ddev = {
			cmd = { "ddev", "exec", "vendor/bin/phpunit" },
			container_path = "/var/www/html",
		},
		phpunit = {
			cmd = { "vendor/bin/phpunit" },
			container_path = nil,
		},
	}

	return configs[runner] or configs.phpunit
end

require("neotest").setup({
	adapters = {
		(function()
			local runner_cfg = get_runner_config()
			local adapter = require("neotest-phpunit")({
				phpunit_cmd = function()
					return runner_cfg.cmd
				end,
				root_files = { "composer.json", ".ddev", ".neotest.lua" },
			})

			local original_results = adapter.results

			adapter.build_spec = function(args)
				local position = args.tree:data()
				local cwd = vim.loop.cwd() or ""
				local runner_cfg = get_runner_config() -- Re-check to allow hot-swapping

				local adjusted_path = position.path
				if adjusted_path:find(cwd, 1, true) == 1 then
					adjusted_path = adjusted_path:sub(#cwd + 2)
				end

				if position.type == "dir" then
					adjusted_path = ""
				end

				vim.fn.mkdir(cwd .. "/storage/logs", "p")

				local host_results = cwd .. "/storage/logs/phpunit-junit.xml"
				local container_results = (runner_cfg.container_path or cwd) .. "/storage/logs/phpunit-junit.xml"

				local command = vim.tbl_flatten({
					runner_cfg.cmd,
					adjusted_path ~= "" and adjusted_path or nil,
					"--log-junit=" .. container_results,
					position.type == "test" and { "--filter", position.name } or nil,
				})

				return {
					command = command,
					context = {
						results_path = host_results,
						container_path = runner_cfg.container_path,
					},
				}
			end

			-- Override results para converter paths do container para host
			adapter.results = function(spec, result, tree)
				local cwd = vim.loop.cwd() or ""
				local container_path = spec.context.container_path

				if container_path then
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

-- Keymaps
vim.keymap.set("n", "<leader>tp", "<cmd>Neotest output-panel toggle<cr>", { desc = "Neotest: Output Panel" })
vim.keymap.set("n", "<leader>ts", "<cmd>Neotest summary toggle<cr>", { desc = "Neotest: Summary" })
vim.keymap.set("n", "<leader>tn", "<cmd>Neotest run<cr>", { desc = "Neotest: Run Nearest" })
vim.keymap.set("n", "<leader>tf", "<cmd>Neotest run file<cr>", { desc = "Neotest: Run File" })
vim.keymap.set("n", "<leader>tl", "<cmd>Neotest run last<cr>", { desc = "Neotest: Run Last" })
