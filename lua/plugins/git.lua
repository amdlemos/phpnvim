-- Custom Git Plugins Configuration

-- Git Conflict: Resolução intuitiva de conflitos
require("git-conflict").setup({
	default_mappings = true, -- Ativa co, ct, cb, etc.
	highlights = {
		incoming = "DiffText",
		current = "DiffAdd",
	},
})

-- Diffview: Interface rica para diffs
require("diffview").setup({
	enhanced_diff_hl = true,
	use_icons = true,
	icons = {
		folder_closed = "",
		folder_open = "",
	},
	signs = {
		fold_closed = "",
		fold_open = "",
		done = "✓",
	},
})
