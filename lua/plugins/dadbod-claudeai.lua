if true then
	return {}
end
return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
	init = function()
		-- Configuração básica do DBUI
		vim.g.db_ui_use_nerd_fonts = 1

		-- Abrir DBUI em uma nova tab
		vim.g.db_ui_win_position = "left"
		vim.g.db_ui_winwidth = 30

		-- Função para abrir DBUI em uma nova tab
		local function open_dbui_in_new_tab()
			vim.cmd("tabnew")
			vim.cmd("DBUI")
		end

		-- Função para alternar DBUI em uma nova tab se não estiver aberto
		local function toggle_dbui_in_tab()
			-- Verifica se já existe um buffer DBUI aberto
			local dbui_open = false
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				local name = vim.api.nvim_buf_get_name(buf)
				if name:match("dbui") then
					dbui_open = true
					break
				end
			end

			if not dbui_open then
				open_dbui_in_new_tab()
			else
				vim.cmd("DBUIToggle")
			end
		end

		-- Configurar atalhos de teclado
		vim.api.nvim_create_user_command("DBUINewTab", open_dbui_in_new_tab, {})

		-- Definir atalhos globais
		vim.keymap.set(
			"n",
			"<Leader>Db",
			toggle_dbui_in_tab,
			{ noremap = true, silent = true, desc = "Abrir DB UI em nova tab" }
		)
		vim.keymap.set(
			"n",
			"<Leader>Dc",
			"<cmd>DBUIAddConnection<CR>",
			{ noremap = true, silent = true, desc = "Adicionar conexão DB" }
		)
		vim.keymap.set(
			"n",
			"<Leader>Df",
			"<cmd>DBUIFindBuffer<CR>",
			{ noremap = true, silent = true, desc = "Encontrar buffer DB" }
		)

		-- Hook para manter os buffers do DBUI separados
		local dbui_augroup = vim.api.nvim_create_augroup("dadbod_ui_config", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = dbui_augroup,
			pattern = { "sql", "mysql", "plsql", "dbui", "dbout" },
			callback = function()
				-- Definir opções locais para buffers relacionados ao DB
				vim.opt_local.buflisted = false
			end,
		})
	end,
}
