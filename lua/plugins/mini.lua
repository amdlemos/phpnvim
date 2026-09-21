-- Mini Plugins Configuration
-- Coleção de módulos minimalistas e eficientes
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("mini.bufremove").setup()
require("mini.indentscope").setup({
	symbol = "│",
	draw = {
		delay = 100,
		animation = nil, -- Sem animação para máxima performance
	},
})

-- Statusline: modo, path/arquivo, diagnostics, LSPs ativos do buffer
local statusline = require("mini.statusline")

local function section_lsp()
	local clients = vim.lsp.get_clients({ bufnr = 0 })
	if #clients == 0 then
		return ""
	end
	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	return " " .. table.concat(names, " ")
end

statusline.setup({
	use_icons = true,
	content = {
		active = function()
			local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
			local git = statusline.section_git({ trunc_width = 40 })
			local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
			-- %F = caminho completo do arquivo
			local filename = "%F %m %r"
			local location = statusline.section_location({ trunc_width = 75 })

			return statusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
				"%<",
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=",
				{ hl = "MiniStatuslineDevinfo", strings = { section_lsp() } },
				{ hl = mode_hl, strings = { location } },
			})
		end,
	},
})

-- Minimapa do buffer (estilo VSCode)
local map = require("mini.map")
map.setup({
	integrations = {
		map.gen_integration.builtin_search(),
		map.gen_integration.diagnostic(),
		map.gen_integration.gitsigns(),
	},
	symbols = {
		encode = map.gen_encode_symbols.dot("4x2"),
	},
	window = {
		width = 10,
		show_integration_count = false,
	},
})

vim.keymap.set("n", "<leader>mm", map.toggle, { desc = "Minimapa: alternar" })
vim.keymap.set("n", "<leader>mf", map.toggle_focus, { desc = "Minimapa: focar" })
vim.keymap.set("n", "<leader>ms", map.toggle_side, { desc = "Minimapa: trocar lado" })
vim.keymap.set("n", "<leader>mr", map.refresh, { desc = "Minimapa: atualizar" })
