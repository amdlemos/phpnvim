-- Configuração de keymaps para LSP
local keymap = vim.keymap.set

-- LSP keymaps (disponíveis quando LSP está ativo)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings
		local opts = { buffer = ev.buf, silent = true }

		-- Navegação
		keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Ir para definição" }))
		keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Ir para declaração" }))
		keymap(
			"n",
			"gi",
			vim.lsp.buf.implementation,
			vim.tbl_extend("force", opts, { desc = "Ir para implementação" })
		)
		keymap("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Mostrar referências" }))
		keymap(
			"n",
			"gt",
			vim.lsp.buf.type_definition,
			vim.tbl_extend("force", opts, { desc = "Ir para definição de tipo" })
		)

		-- Informações
		keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Mostrar documentação" }))
		keymap("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Mostrar assinatura" }))

		-- Code actions e refactoring
		keymap(
			{ "n", "v" },
			"<leader>ca",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, { desc = "Code Actions" })
		)
		keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Renomear símbolo" }))

		-- Formatação
		keymap({ "n", "v" }, "<leader>cf", function()
			vim.lsp.buf.format({ async = true })
		end, vim.tbl_extend("force", opts, { desc = "Formatar código" }))

		-- Diagnósticos
		keymap(
			"n",
			"<leader>E",
			vim.diagnostic.open_float,
			vim.tbl_extend("force", opts, { desc = "Mostrar diagnóstico" })
		)
		keymap("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Diagnóstico anterior" }))
		keymap("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Próximo diagnóstico" }))
		keymap(
			"n",
			"<leader>q",
			vim.diagnostic.setloclist,
			vim.tbl_extend("force", opts, { desc = "Lista de diagnósticos" })
		)

		-- Workspace
		keymap(
			"n",
			"<leader>wa",
			vim.lsp.buf.add_workspace_folder,
			vim.tbl_extend("force", opts, { desc = "Adicionar pasta ao workspace" })
		)
		keymap(
			"n",
			"<leader>wr",
			vim.lsp.buf.remove_workspace_folder,
			vim.tbl_extend("force", opts, { desc = "Remover pasta do workspace" })
		)
		keymap("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, vim.tbl_extend("force", opts, { desc = "Listar pastas do workspace" }))
	end,
})

-- Keymaps globais para diagnósticos (sempre disponíveis)
keymap("n", "<leader>d", "", { desc = "Diagnósticos" })
keymap("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Mostrar diagnóstico", silent = true })
keymap("n", "<leader>da", vim.diagnostic.setqflist, { desc = "Todos os diagnósticos", silent = true })
keymap("n", "<leader>dn", vim.diagnostic.goto_next, { desc = "Próximo diagnóstico", silent = true })
keymap("n", "<leader>dp", vim.diagnostic.goto_prev, { desc = "Diagnóstico anterior", silent = true })

-- Configurar aparência dos diagnósticos
vim.diagnostic.config({
	virtual_text = {
		prefix = "●",
		source = "if_many",
	},
	float = {
		source = "always",
		border = "rounded",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- Ícones para diagnósticos
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
