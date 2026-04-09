-- tiny-code-action.nvim + Telescope integration
local tiny_code_action = require("tiny-code-action")

tiny_code_action.setup({
  picker = "telescope"
})

-- Keymap: <leader>ca para abrir code actions
vim.keymap.set("n", "<leader>ca", function()
  tiny_code_action.code_action()
end, { desc = "Ações de código (Telescope)", silent = true })
