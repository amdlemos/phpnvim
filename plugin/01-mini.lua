-- if true then
-- 	return
-- end
vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.icons", branch = "stable" },
	{ src = "https://github.com/nvim-mini/mini.pairs", branch = "stable" },
}, { load = true })

require("mini.pairs").setup()
require("mini.icons").setup()
