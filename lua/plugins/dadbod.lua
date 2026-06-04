vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

vim.g.dbs = {
	{ name = "runy-v1", url = "mysql://db:db@127.0.0.1:3306/db" },
	{ name = "runy-v2", url = "mysql://root:password@127.0.0.1:3307/laravel" },
	{
		name = "certificados-join",
		url = "sqlite:/home/amdlemos/github/back-end2023/dev-docs/certificados-join/data/certificados_join.db",
	},
}

vim.keymap.set("n", "<leader>D", "<cmd>DBUIToggle<cr>", { desc = "Abrir DB UI" })

-- Ensure vertical navigation works from DB UI buffers
vim.api.nvim_create_autocmd("FileType", {
	pattern = "dbui",
	callback = function()
		local opts = { buffer = true, silent = true }
		-- Ctrl-j / Ctrl-Down -> move to window below
		vim.keymap.set("n", "<C-j>", function()
			vim.cmd("wincmd j")
		end, vim.tbl_extend("force", opts, { desc = "DBUI: window below" }))

		-- Ctrl-k / Ctrl-Up -> move to window above
		vim.keymap.set("n", "<C-k>", function()
			vim.cmd("wincmd k")
		end, vim.tbl_extend("force", opts, { desc = "DBUI: window above" }))

		-- Vim-style tree navigation like Neo-tree: l -> child/enter
		vim.keymap.set(
			"n",
			"l",
			"<Plug>(DBUI_GotoChildNode)",
			vim.tbl_extend("force", opts, { desc = "DBUI: goto child/enter" })
		)
		-- h: collapse node if open, otherwise go to parent
		vim.keymap.set(
			"n",
			"h",
			"<Plug>(DBUI_GotoParentNode)",
			vim.tbl_extend("force", opts, { desc = "DBUI: collapse node" })
		)
	end,
})
