-- if true then
-- 	return
-- end
vim.pack.add({
	{ src = "https://github.com/nvim-tree/nvim-tree.lua" },
}, { load = true })

local VIEW_WIDTH_FIXED = 30
local view_width_max = VIEW_WIDTH_FIXED -- fixed to start

-- toggle the width and redraw
local function toggle_width_adaptive()
	if view_width_max == -1 then
		view_width_max = VIEW_WIDTH_FIXED
	else
		view_width_max = -1
	end

	require("nvim-tree.api").tree.reload()
end
-- get current view width
local function get_view_width_max()
	return view_width_max
end

require("nvim-tree").setup({
	git = {
		enable = true,
	},
	view = {
		width = {
			min = 30,
			max = get_view_width_max,
		},
	},
	update_focused_file = {
		enable = true, -- Habilita o recurso de sincronização
		update_cwd = false, -- Atualiza o diretório atual da árvore
		ignore_list = {}, -- Arquivos ou diretórios que você deseja ignorar
	},
})
vim.keymap.set("n", "<leader>A", toggle_width_adaptive, { desc = "Adjust Nvim-Tree" })
local keymap = vim.keymap.set
local s = { silent = true }

-- Nvim Tree
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", s)
