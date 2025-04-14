
-- Criar um atalho para remover uma marca após digitar a marca desejada
vim.api.nvim_set_keymap('n', '<leader>h', ':lua RemoveMark()<CR>', { noremap = true, silent = false })

-- Função Lua para remover a marca
function RemoveMark()
  local marca = vim.fn.input('Digite a marca para remover: ')
  vim.cmd('delmarks ' .. marca)
end
