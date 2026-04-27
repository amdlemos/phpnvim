-- Neotest Configuration
-- Suporta Sail, DDEV e PHPUnit/Pest local com detecção automática

-- Substitui vim.tbl_flatten (depreciado) por vim.iter flatten
local function tbl_flatten(t)
	return vim.iter(t):flatten(math.huge):totable()
end

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
			phpunit_cmd = { "vendor/bin/sail", "test" },
			pest_cmd = { "vendor/bin/sail", "bin", "pest" },
			container_path = "/var/www/html",
		},
		ddev = {
			phpunit_cmd = { "ddev", "exec", "vendor/bin/phpunit" },
			pest_cmd = { "ddev", "exec", "vendor/bin/pest" },
			container_path = "/var/www/html",
		},
		phpunit = {
			phpunit_cmd = { "vendor/bin/phpunit" },
			pest_cmd = { "vendor/bin/pest" },
			container_path = nil,
		},
	}

	return configs[runner] or configs.phpunit
end

local function build_phpunit_adapter()
	local runner_cfg = get_runner_config()
	local adapter = require("neotest-phpunit")({
		phpunit_cmd = function()
			return runner_cfg.phpunit_cmd
		end,
		root_files = { "composer.json", ".ddev", ".neotest.lua" },
	})

	local original_results = adapter.results

	adapter.build_spec = function(args)
		local position = args.tree:data()
		local cwd = vim.loop.cwd() or ""
		local cfg = get_runner_config() -- Re-check para permitir hot-swap

		local adjusted_path = position.path
		if adjusted_path:find(cwd, 1, true) == 1 then
			adjusted_path = adjusted_path:sub(#cwd + 2)
		end

		if position.type == "dir" then
			adjusted_path = ""
		end

		vim.fn.mkdir(cwd .. "/storage/logs", "p")

		local host_results = cwd .. "/storage/logs/phpunit-junit.xml"
		local container_results = (cfg.container_path or cwd) .. "/storage/logs/phpunit-junit.xml"

		local command = tbl_flatten({
			cfg.phpunit_cmd,
			adjusted_path ~= "" and adjusted_path or nil,
			"--log-junit=" .. container_results,
			position.type == "test" and { "--filter", position.name } or nil,
		})

		return {
			command = command,
			context = {
				results_path = host_results,
				container_path = cfg.container_path,
			},
		}
	end

	-- Override results para converter paths do container para host
	adapter.results = function(spec, result, tree)
		local cwd = vim.loop.cwd() or ""
		local container_path = spec.context.container_path

		if container_path then
			local f = io.open(spec.context.results_path, "r")
			if f then
				local content = f:read("*a")
				f:close()

				content = content:gsub(container_path, cwd)

				f = io.open(spec.context.results_path, "w")
				if f then
					f:write(content)
					f:close()
				end
			end
		end

		return original_results(spec, result, tree)
	end

	return adapter
end

local function build_pest_adapter()
	local runner_cfg = get_runner_config()
	-- Desabilita a detecção automática de Sail do neotest-pest para usar
	-- nosso próprio pest_cmd que já considera Sail, DDEV ou local
	return require("neotest-pest")({
		pest_cmd = function()
			return runner_cfg.pest_cmd
		end,
		sail_enabled = false,
		root_files = { "tests/Pest.php", "composer.json" },
	})
end

require("neotest").setup({
	adapters = {
		build_phpunit_adapter(),
		build_pest_adapter(),
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
