-- Mini Plugins Configuration
-- Coleção de módulos minimalistas e eficientes

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
-- require("mini.git").setup()
require("mini.bufremove").setup()
require("mini.ai").setup()
-- require("mini.files").setup({
-- 	windows = {
-- 		preview = true,
-- 		width_focus = 30,
-- 		width_preview = 80,
-- 	},
-- 	options = {
-- 		use_as_default_explorer = true,
-- 	},
-- })
require("mini.indentscope").setup({
	symbol = "│",
	draw = {
		delay = 100,
		animation = nil, -- Sem animação para máxima performance
	},
})
require("mini.tabline").setup()

local function get_lsp_status()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end
	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	return "󰒋 [" .. table.concat(names, ", ") .. "]"
end

require("mini.statusline").setup({
	content = {
		active = function()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })
			local lsp = get_lsp_status()

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics, lsp } },
				"%<", -- Mark general truncate point
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=", -- End left alignment
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = mode_hl, strings = { location } },
			})
		end,
	},
})
