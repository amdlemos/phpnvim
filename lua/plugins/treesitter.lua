-- Treesitter Manager Configuration
-- Substitui nvim-treesitter (arquivado) para instalar/gerenciar parsers
-- Requer: tree-sitter CLI, gcc/clang, git

require("tree-sitter-manager").setup()

vim.keymap.set("n", "<leader>ts", "<cmd>TSManager<cr>", { desc = "Gerenciar parsers Treesitter" })
