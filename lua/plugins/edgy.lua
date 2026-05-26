require("edgy").setup({
	animate = { enabled = false },
	exit_when_last = false,
	keys = {
		["<C-Left>"] = function(win)
			win:resize("width", -10)
		end,
		["<C-Right>"] = function(win)
			win:resize("width", 10)
		end,
		["<C-Up>"] = function(win)
			win:resize("height", -10)
		end,
		["<C-Down>"] = function(win)
			win:resize("height", 10)
		end,
	},
	wo = {
		winbar = true,
		winfixwidth = true,
		winfixheight = true,
		signcolumn = "no",
	},
	left = {
		{
			title = "Símbolos",
			ft = "trouble",
			filter = function(_, win)
				return vim.w[win].trouble and vim.w[win].trouble.mode == "symbols"
			end,
			size = { width = 40 },
			open = function()
				require("trouble").open({ mode = "symbols", focus = false })
			end,
		},
		-- {
		-- 	title = "Neo-tree",
		-- 	ft = "neo-tree",
		-- 	filter = function(buf)
		-- 		return vim.b[buf].neo_tree_source == "filesystem"
		-- 	end,
		-- 	size = { width = 30 },
		-- 	open = "Neotree filesystem",
		-- },
	},
	bottom = {
		{
			title = "Diagnósticos",
			ft = "trouble",
			filter = function(_, win)
				return vim.w[win].trouble and vim.w[win].trouble.mode == "diagnostics"
			end,
			size = { height = 15 },
			open = function()
				require("trouble").open({ mode = "diagnostics", filter = { buf = 0 } })
			end,
		},
		{
			title = "Referências",
			ft = "trouble",
			filter = function(_, win)
				return vim.w[win].trouble and vim.w[win].trouble.mode == "lsp_references"
			end,
			size = { height = 15 },
			open = function()
				require("trouble").open({ mode = "lsp_references" })
			end,
		},
	},
})
