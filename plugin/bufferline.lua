-- if true then
-- 	return
-- end
vim.pack.add({
	{ src = "https://github.com/akinsho/bufferline.nvim" },
}, { load = true })

require("bufferline").setup({
	options = {
		mode = "buffers",
		diagnostics = "nvim_lsp",
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
