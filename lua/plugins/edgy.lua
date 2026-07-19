require("edgy").setup({
	animate = { enabled = false },
	exit_when_last = false,
	-- Largura única por borda: nenhuma view da esquerda define width própria,
	-- então a coluna nunca muda de tamanho ao alternar views
	options = {
		left = { size = 30 },
		right = { size = 30 },
	},
	keys = {
		["<C-Left>"] = function(win)
			win:resize("width", -10)
		end,
		["<C-Right>"] = function(win)
			win:resize("width", 10)
		end,
		["<C-Up>"] = function(win)
			win:resize("height", 5)
		end,
		["<C-Down>"] = function(win)
			win:resize("height", -5)
		end,
	},
	left = {
		{
			title = "Neo-Tree",
			ft = "neo-tree",
			filter = function(buf)
				return vim.b[buf].neo_tree_source == "filesystem"
			end,
			size = { height = 0.5 },
			-- winbar fica com o source_selector do neo-tree, não com o título do edgy
			wo = { winbar = false },
		},
		{
			title = "Buffers",
			ft = "neo-tree",
			filter = function(buf)
				return vim.b[buf].neo_tree_source == "buffers"
			end,
			size = { height = 0.25 },
			open = "Neotree buffers",
			wo = { winbar = false },
		},
		{
			title = "Git",
			ft = "neo-tree",
			filter = function(buf)
				return vim.b[buf].neo_tree_source == "git_status"
			end,
			size = { height = 0.25 },
			open = "Neotree git_status",
			wo = { winbar = false },
		},
		{
			title = "DB UI",
			ft = "dbui",
			open = "DBUIToggle",
		},
		{
			title = "Símbolos",
			ft = "trouble",
			filter = function(_, win)
				return vim.w[win].trouble and vim.w[win].trouble.mode == "symbols"
			end,
			open = function()
				require("trouble").open({ mode = "symbols", focus = false })
			end,
		},
		{
			title = "Neotest",
			ft = "neotest-summary",
		},
	},
	right = {
		{
			title = "Repl",
			ft = "dap-repl",
			open = function()
				require("dapui").open()
			end,
		},
		{
			title = "Watches",
			ft = "dapui_watches",
			open = function()
				require("dapui").open()
			end,
		},
		{
			title = "Breakpoints",
			ft = "dapui_breakpoints",
			open = function()
				require("dapui").open()
			end,
		},
	},
	bottom = {
		{
			title = "DB Output",
			ft = "dbout",
			size = { height = 15 },
		},
		{
			title = "Diagnósticos",
			ft = "trouble",
			filter = function(_, win)
				return vim.w[win].trouble and vim.w[win].trouble.mode == "diagnostics"
			end,
			size = { height = 10 },
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
			size = { height = 10 },
			open = function()
				require("trouble").open({ mode = "lsp_references" })
			end,
		},
	},
})
