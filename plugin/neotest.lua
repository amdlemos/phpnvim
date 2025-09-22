return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"olimorris/neotest-phpunit",
		"V13Axel/neotest-pest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-phpunit")({
					root_ignore_files = { "tests/Pest.php" },
				}),
				require("neotest-pest")({
					sail_enabled = function()
						return true
					end,

					sail_executable = { "docker", "compose", "-f", "docker-compose.dev.yml", "exec", "app" },

					sail_project_path = "/var/www/html",
					pest_cmd = function()
						return {
							"vendor/bin/pest",
							"--log-junit=/var/www/html/storage/junit-report.xml",
						}
					end,

					results_path = function()
						return vim.fn.getcwd() .. "/storage/junit-report.xml"
					end,
				}),
			},
		})
	end,
	keys = {
		{
			"<leader>tn",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Run nearest test",
		},
		{
			"<leader>tT",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Run all tests",
		},
		{
			"<leader>ts",
			"<cmd>Neotest summary open<cr>",
			desc = "Displays test suite structure",
		},
		{
			"<leader>to",
			"<cmd>Neotest output-panel toggle<cr>",
			desc = "Toggle output panel",
		},
	},
}
