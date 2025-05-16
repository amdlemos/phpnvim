return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	init = function()
		-- Usa ícones bonitinhos se tiver NerdFonts
		vim.g.db_ui_use_nerd_fonts = 1

		-- Abre DBUI sempre em uma nova tab
		vim.api.nvim_create_user_command("DBUITab", function()
			vim.cmd("tabnew | DBUI")
		end, {})

		-- Atalhos (coloque os que achar melhor)
		vim.keymap.set("n", "<leader>Db", "<cmd>DBUITab<CR>", { desc = "Abrir Dadbod UI em nova tab" })
		vim.keymap.set("n", "<leader>Dc", "<cmd>DBUIAddConnection<CR>", { desc = "Adicionar conexão DB" })
		vim.keymap.set("n", "<leader>Dq", "<cmd>tabclose<CR>", { desc = "Fechar tab atual (DBUI)" })
	end,
}
