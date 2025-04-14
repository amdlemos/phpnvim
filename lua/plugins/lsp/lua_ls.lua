
			lspconfig.lua_ls.setup({
				on_attach = function(client)
					-- client.server_capabilities.documentFormattingProvider = false
					-- client.server_capabilities.documentRangeFormattingProvider = false
				end,
				capabilities = blink_capabilities,
				settings = {
					Lua = {
						format = { enable = false },
						diagnostics = {
							globals = { "vim", "Snacks" },
						},
					},
				},
			})
