-- Snacks Configuration

require("snacks").setup({
	statuscolumn = {
		enabled = true,
		left = { "mark", "sign" },
		-- right = { "fold", "git" },
		right = { "fold" },
		folds = {
			open = true,
			-- git_hl = true,
		},
		-- git = {
		-- 	patterns = { "GitSign", "MiniDiffSign" },
		-- },
		refresh = 200,
	},
	indent = { enabled = true },
})
