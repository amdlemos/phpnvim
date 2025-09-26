local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
local winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None"

require("blink.cmp").setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
	keymap = { preset = "default" },
	appearance = {
		use_nvim_cmp_as_default = true,
		nerd_font_variant = "normal",
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
	},

	-- completion = {
	-- 	documentation = {
	-- 		auto_show = true,
	-- 		-- auto_show_delay_ms = 200,
	-- 	},
	-- },

	-- cmdline = {
	-- 	keymap = {
	-- 		preset = "inherit",
	-- 		["<CR>"] = { "accept_and_enter", "fallback" },
	-- 	},
	-- },

	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 100,
			},
		},
	},
})
