-- local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None"
return {
	{
		"saghen/blink.cmp",
		enabled = true,
		-- optional: provides snippets for the snippet source
		dependencies = {
			{ "rafamadriz/friendly-snippets" },
			{ "onsails/lspkind.nvim" },
			{ "echasnovski/mini.icons", version = false },
		},

		-- use a release tag to download pre-built binaries
		version = "*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' for mappings similar to built-in completion
			-- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
			-- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
			-- See the full "keymap" documentation for information on defining your own keymap.
			keymap = { preset = "default" },

			appearance = {
				-- Sets the fallback highlight groups to nvim-cmp's highlight groups
				-- Useful for when your theme doesn't support blink.cmp
				-- Will be removed in a future release
				-- use_nvim_cmp_as_default = true,
				-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},
			completion = {
				keyword = { range = "full" },
				menu = {
					-- Don't automatically show the completion menu
					auto_show = true,
					-- border = border,
					winhighlight = winhighlight,
					draw = {
						columns = {
							{ "kind_icon", "kind", gap = 2 },
							{ "label", "label_description", "source_name", gap = 1 },
						},
						components = {
							kind_icon = {
								ellipsis = false,
								text = function(ctx)
									local miniIcons = require("mini.icons")
									if ctx.kind == "Folder" then
										return miniIcons.get("directory", ctx.label)
									end
									if ctx.kind == "File" then
										return miniIcons.get("file", ctx.label)
									end
									if ctx.kind == "Copilot" then
										return ""
									end
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- Optionally, you may also use the highlights from mini.icons
								highlight = function(ctx)
									if ctx.kind == "Folder" then
										local _, hl, _ = require("mini.icons").get("directory", ctx.label)
										return hl
									end
									if ctx.kind == "File" then
										local _, hl, _ = require("mini.icons").get("file", ctx.label)
										return hl
									end
									if ctx.kind == "Copilot" then
										local _, hl, _ = require("mini.icons").get("os", "nixos")
										return hl
									end
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							kind = {
								text = function(ctx)
									return " " .. ctx.kind
								end,
							},
						},
					},
				},
				documentation = {
					window = {
						border = border,
						winhighlight = winhighlight,
					},
					-- window = { border = "single" },
					auto_show = true,
					auto_show_delay_ms = 500,
				},

				-- Display a preview of the selected item on the current line
				ghost_text = { enabled = false },

				trigger = {
					show_on_keyword = true,
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = { sql = { "dadbod" } },
				providers = {
					dadbod = { module = "vim_dadbod_completion.blink" },
				},
			},
		},
		opts_extend = { "sources.default" },
	},
}
