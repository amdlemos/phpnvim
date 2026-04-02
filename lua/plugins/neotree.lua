require("neo-tree").setup({
	close_if_last_window = false,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	window = {
		position = "left",
		width = 30,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
		},
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
		},
	},
	sources = {
		"filesystem",
		"buffers",
		"git_status",
	},
})
