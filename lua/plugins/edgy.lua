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
			win:resize("height", 5)
		end,
		["<C-Down>"] = function(win)
			win:resize("height", -5)
		end,
	},
	left = {

		-- {
		-- 	title = "Neo-tree",
		-- 	ft = "neo-tree",
		-- 	filter = function(buf)
		-- 		return vim.b[buf].neo_tree_source == "filesystem"
		-- 	end,
		-- 	size = { width = 30 },
		-- 	open = "Neotree filesystem",
		-- },
		{
			title = "Neo-Tree",
			ft = "neo-tree",
			filter = function(buf)
				return vim.b[buf].neo_tree_source == "filesystem"
			end,
			size = { height = 0.5, width = 30 },
		},
		-- {
		-- 	title = "Buffers",
		-- 	ft = "neo-tree",
		-- 	filter = function(buf)
		-- 		return vim.b[buf].neo_tree_source == "buffers"
		-- 	end,
		-- 	size = { width = 30 },
		-- 	open = "Neotree buffers",
		-- },
		-- {
		-- 	title = "Git",
		-- 	ft = "neo-tree",
		-- 	filter = function(buf)
		-- 		return vim.b[buf].neo_tree_source == "git_status"
		-- 	end,
		-- 	size = { width = 30 },
		-- 	open = "Neotree git_status",
		-- },

		-- {
		-- 	title = "Neo-Tree Buffers",
		-- 	ft = "neo-tree",
		-- 	filter = function(buf)
		-- 		return vim.b[buf].neo_tree_source == "buffers"
		-- 	end,
		-- 	pinned = true,
		-- 	collapsed = true, -- show window as closed/collapsed on start
		-- 	open = "Neotree position=top buffers",
		-- },

		{
			title = "DB UI",
			ft = "dbui",
			size = { width = 40 },
			open = "DBUIToggle",
		},
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
		{
			title = "Neotest",
			ft = "neotest-summary",
			size = { width = 40 },
			-- open = "DBUIToggle",
		},
	},
	right = {
		{
			title = "Repl",
			ft = "dap-repl",
			size = { width = 30 },
			open = function()
				require("dapui").open()
			end,
		},
		{
			title = "Watches",
			ft = "dapui_watches",
			size = { width = 30 },
			open = function()
				require("dapui").open()
			end,
		},
		{
			title = "Breakpoints",
			ft = "dapui_breakpoints",
			size = { width = 30 },
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
