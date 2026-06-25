-- LSP On Attach
-- Função centralizada chamada quando um servidor LSP anexa a um buffer

local keymap = vim.keymap.set

return function(client, bufnr)
	-- Buffer local mappings
	local opts = { buffer = bufnr, silent = true }

	-- Navegação (nativo LSP)
	keymap("n", "gd", function()
		vim.lsp.buf.definition({
			on_list = function(result)
				local function jump(item)
					vim.cmd.edit(item.filename)
					vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
				end

				if #result.items == 1 then
					jump(result.items[1])
					return
				end

				-- Múltiplos resultados: selecionar em float via fzf-lua
				vim.cmd.packadd("fzf-lua")
				local fzf = require("fzf-lua")
				local entries = {}
				for i, item in ipairs(result.items) do
					local short = vim.fn.fnamemodify(item.filename or "", ":~:.")
					entries[i] = string.format("%s|%d col %d| %s", short, item.lnum, item.col, item.text or "")
				end
				fzf.fzf_exec(entries, {
					prompt = "Ir para definição> ",
					winopts = { height = 0.4, width = 0.7 },
					actions = {
						["default"] = function(selected)
							if not selected or #selected == 0 then
								return
							end
							for i, entry in ipairs(entries) do
								if entry == selected[1] then
									jump(result.items[i])
									break
								end
							end
						end,
					},
				})
			end,
		})
	end, vim.tbl_extend("force", opts, { desc = "Ir para definição" }))
	keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Ir para declaração" }))
	keymap("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Ir para implementação" }))
	keymap("n", "gr", function()
		require("trouble").open("lsp_references")
	end, vim.tbl_extend("force", opts, { desc = "Mostrar referências (Trouble)" }))
	keymap(
		"n",
		"gt",
		vim.lsp.buf.type_definition,
		vim.tbl_extend("force", opts, { desc = "Ir para definição de tipo" })
	)

	-- Informações
	keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Mostrar documentação" }))
	-- keymap("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Mostrar assinatura" }))

	-- Code actions e refactoring
	-- keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
	keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Renomear símbolo" }))

	-- Formatação
	keymap({ "n", "v" }, "<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, vim.tbl_extend("force", opts, { desc = "Formatar código" }))

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
end
