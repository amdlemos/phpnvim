require("kulala").setup({
	max_response_size = 65768,
})
vim.keymap.set("n", "<leader>rr", function()
	require("kulala").run()
end, { desc = "Run request" })

vim.keymap.set("n", "<leader>ra", function()
	require("kulala").run_all()
end, { desc = "Run all requests" })

vim.keymap.set("n", "<leader>rp", function()
	require("kulala").jump_prev()
end, { desc = "Jump to previous request" })

vim.keymap.set("n", "<leader>rn", function()
	require("kulala").jump_next()
end, { desc = "Jump to next request" })

vim.keymap.set("n", "<leader>rb", function()
	require("kulala").scratchpad()
end, { desc = "Open scratchpad" })

vim.keymap.set("n", "<leader>ro", function()
	require("kulala").open()
end, { desc = "Open request" })

vim.keymap.set("n", "<leader>rt", function()
	require("kulala").toggle_view()
end, { desc = "Toggle view" })
