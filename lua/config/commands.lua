vim.g["diagnostics_active"] = true
function Toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    -- vim.diagnostic.disable()
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.enable()
  end
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Configuração geral dos diagnósticos
vim.diagnostic.config({
  virtual_text = false, -- Desabilita o texto virtual (opcional)
  signs = true,        -- Mostra os sinais na coluna lateral
  underline = true,
  severity_sort = true,
  update_in_insert = false,
})

vim.keymap.set(
  "n",
  "<leader>xd",
  Toggle_diagnostics,
  { noremap = true, silent = true, desc = "Toggle vim diagnostics" }
)

vim.cmd("colorscheme astromars")
vim.cmd("set termguicolors")

-- Atualiza automaticamente arquivos alterados externamente
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  command = "checktime",
})

-- Função para alternar entre os temas
function ToggleTheme()
  if vim.o.background == "light" then
    vim.o.background = "dark"
    vim.cmd("colorscheme astromars") -- Mude para o tema escuro
  else
    vim.o.background = "light"
    vim.cmd("colorscheme astrolight") -- Mude para o tema claro
  end
end

-- Mapeie a função a um comando
vim.api.nvim_create_user_command("ToggleTheme", ToggleTheme, {})
-- Mapeamento de tecla (ex: Ctrl + t para alternar o tema)
vim.api.nvim_set_keymap("n", "<C-t>", ":ToggleTheme<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- ]t para ir para a próxima aba
vim.api.nvim_set_keymap("n", "]t", ":tabnext<CR>", { noremap = true, silent = true })

-- [t para ir para a aba anterior
vim.api.nvim_set_keymap("n", "[t", ":tabprevious<CR>", { noremap = true, silent = true })

-- Configuração dos keymaps do terminal
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  -- Esc duas vezes para entrar no modo normal
  vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], opts)
  -- Alt + hjkl para navegar entre janelas em modo terminal
  -- vim.keymap.set('t', '<A-h>', [[<C-\><C-n><C-W>h]], opts)
  -- vim.keymap.set('t', '<A-j>', [[<C-\><C-n><C-W>j]], opts)
  -- vim.keymap.set('t', '<A-k>', [[<C-\><C-n><C-W>k]], opts)
  -- vim.keymap.set('t', '<A-l>', [[<C-\><C-n><C-W>l]], opts)
  -- Ctrl + hjkl para navegar em modo normal
  -- vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
  -- vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
  -- vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
  -- vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
end

-- Autocommand para aplicar os keymaps quando abrir um terminal
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
