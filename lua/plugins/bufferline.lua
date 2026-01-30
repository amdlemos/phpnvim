-- Bufferline Configuration

require("bufferline").setup({
	options = {
		mode = "buffers",
		offsets = {
			{
				filetype = "neo-tree",
				text = "NeoTree",
				separator = true,
				text_align = "center",
			},
		},
		show_close_icon = false,
		show_buffer_close_icons = false,
	},
})
