if true then
	return {}
end
return {
	"nvimdev/lspsaga.nvim",
	config = function()
		require("lspsaga").setup({
			ui = { sign = false },
		})

		vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
		vim.keymap.set("v", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
