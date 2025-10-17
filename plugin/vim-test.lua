-- Configuração do vim-test para Docker (sem neotest)
vim.g["test#php#pest#executable"] = "docker compose -f docker-compose.override.yml exec -T app vendor/bin/pest"
vim.g["test#strategy"] = "neovim"
vim.g["test#neovim#term_position"] = "vertical botright" -- Divisão vertical à direita
vim.g["test#neovim#term_size"] = 80 -- Largura do terminal (80 colunas)
-- Não entrar automaticamente em modo insert para permitir navegação
vim.g["test#neovim#start_insert"] = 0
