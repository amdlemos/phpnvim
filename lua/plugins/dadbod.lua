vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

vim.g.dbs = {
	{ name = "laravel", url = "mysql://root:password@127.0.0.1:3307/laravel" },
}

vim.keymap.set("n", "<leader>D", "<cmd>DBUIToggle<cr>", { desc = "Abrir DB UI" })
