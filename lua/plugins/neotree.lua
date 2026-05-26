require("neo-tree").setup({
	close_if_last_window = false,
	popup_border_style = "rounded",
	enable_git_status = true,
	enable_diagnostics = true,
	sources = {
		"filesystem",
		"buffers",
		"git_status",
	},
	source_selector = {
		winbar = true,
		content_layout = "center",
		sources = {
			{ source = "filesystem", display_name = "󰉓 Files" },
			{ source = "buffers", display_name = "󰈙 Buffers" },
			{ source = "git_status", display_name = "󰊢 Git" },
		},
	},
	window = {
		position = "right",
		width = 30,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
			["[b"] = "prev_source",
			["]b"] = "next_source",
		},
	},
	filesystem = {
		follow_current_file = {
			enabled = true,
		},
		use_libuv_file_watcher = true,
		filtered_items = {
			visible = false,
			hide_dotfiles = false,
			hide_gitignored = true,
		},
	},
	buffers = {
		follow_current_file = {
			enabled = true,
		},
		show_unloaded = true,
	},
	git_status = {
		window = {
			mappings = {
				["A"] = "git_add_all",
				["gu"] = "git_unstage_file",
				["ga"] = "git_add_file",
				["gr"] = "git_revert_file",
				["gc"] = "git_commit",
				["gp"] = "git_push",
				["gg"] = "git_commit_and_push",
			},
		},
	},
})

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })
vim.keymap.set("n", "<leader>o", "<cmd>Neotree focus<cr>", { desc = "Focar Neo-tree" })
vim.keymap.set("n", "<leader>ge", "<cmd>Neotree git_status<cr>", { desc = "Neo-tree Git Status" })
vim.keymap.set("n", "<leader>be", "<cmd>Neotree buffers<cr>", { desc = "Neo-tree Buffers" })
