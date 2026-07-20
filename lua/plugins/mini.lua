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
