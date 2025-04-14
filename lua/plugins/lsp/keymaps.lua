
			local keymap = vim.keymap
			local buf = vim.lsp.buf
			keymap.set("n", "K", buf.hover, { desc = "LSP Hover" })
			keymap.set("n", "gd", buf.definition, { desc = "LSP Definition" })
			keymap.set("n", "gD", buf.declaration, { desc = "LSP Declaration" })
			keymap.set("n", "gi", buf.implementation, { desc = "LSP implementation" })
			keymap.set("n", "gr", buf.references, { desc = "LSP References" })
			keymap.set("n", "rn", buf.rename, { desc = "LSP Rename" })
			-- keymap.set("n", "D", buf.type_definition, { desc = "LSP Definition" })
			keymap.set({ "n", "v" }, "<leader>ca", buf.code_action, { desc = "LSP Code Action" })
