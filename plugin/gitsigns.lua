-- if true then
-- 	return
-- end
vim.pack.add({
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
}, { load = true })

require("gitsigns").setup({})
