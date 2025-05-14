return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
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
				update_cwd = true, -- Atualiza o diretório atual da árvore
				ignore_list = {}, -- Arquivos ou diretórios que você deseja ignorar
			},
		})
		vim.keymap.set("n", "<leader>A", toggle_width_adaptive, { desc = "Adjust Nvim-Tree" })
	end,
	keys = {
		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
	},
}
