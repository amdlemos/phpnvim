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
		require("neotest-phpunit")({
			phpunit_cmd = function()
				return { vim.fn.expand("~/.config/ddev.sh") }
			end,
		}),
	},
	-- Desabilita a janela flutuante automática
	output = {
		enabled = true,
		open_on_run = false, -- Esta é a chave importante!
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
