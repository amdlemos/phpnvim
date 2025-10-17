# Configuração do Vim-test com Docker para Pest

Esta configuração permite executar testes Pest via Docker diretamente do Neovim usando apenas o vim-test (sem neotest).

## Plugins Instalados

- `vim-test/vim-test` - Runner de testes extremamente robusto e confiável
- `famiu/bufdelete.nvim` - Gerenciamento inteligente de buffers (preserva layout)
- `nvim-telescope/telescope-frecency.nvim` - Arquivos recentes inteligentes (frequência + recência)
- `nvim-lualine/lualine.nvim` - Statusline bonita e global (sempre visível)

**SOLUÇÃO DEFINITIVA**: Removemos completamente o neotest que estava causando problemas e usamos apenas o vim-test, que é muito mais simples e confiável.

## Configuração

A configuração está localizada em `/plugin/vim-test.lua` e é **ultra simples**:

- **Apenas vim-test**: Sem neotest, sem complexidade
- **Comando Docker configurado**: `docker compose -f docker-compose.dev.yml exec -T app vendor/bin/pest`
- **Terminal vertical**: Testes executam em painel vertical à direita (80 colunas)
- **Layout otimizado**: Código à esquerda, output dos testes à direita
- **Zero problemas**: Vim-test é usado há anos e sempre funciona

## Keymaps

### Executar Testes
| Tecla | Ação | Descrição |
|-------|------|-----------|
| `<leader>tt` | `:TestNearest` | Executa o teste sob o cursor |
| `<leader>tf` | `:TestFile` | Executa todos os testes do arquivo atual |
| `<leader>tl` | `:TestLast` | Repete o último teste executado |
| `<leader>tv` | `:TestVisit` | Navega para o último arquivo de teste |

### Navegação no Terminal
| Tecla | Ação | Descrição |
|-------|------|-----------|
| `<Esc>` | Sair do modo insert | Sai do modo insert do terminal |
| `<C-h>` | Navegar esquerda | Vai para janela à esquerda |
| `<C-j>` | Navegar abaixo | Vai para janela abaixo |
| `<C-k>` | Navegar acima | Vai para janela acima |
| `<C-l>` | Navegar direita | Vai para janela à direita |

### Gerenciamento de Buffers
| Tecla | Ação | Descrição |
|-------|------|-----------|
| `<leader>bd` | `:Bdelete` | Fecha buffer atual (preserva layout) |
| `<leader>bD` | `:Bdelete!` | Força fechar buffer atual |

### Telescope (Busca de Arquivos)
| Tecla | Ação | Descrição |
|-------|------|-----------|
| `<leader>ff` | `find_files` | Buscar arquivos no projeto |
| `<leader>fr` | `frecency` | **Arquivos recentes** (inteligente) |
| `<leader>fo` | `oldfiles` | Arquivos recentes (simples) |
| `<leader>/` | `live_grep` | Buscar texto nos arquivos |
| `<leader>fb` | `buffers` | Buscar entre buffers abertos |
| `<leader>fh` | `help_tags` | Buscar na ajuda do Neovim |

### Telescope Git
| Tecla | Ação | Descrição |
|-------|------|-----------|
| `<leader>gF` | `git_files` | **Arquivos no Git** (tracked) |
| `<leader>gs` | `git_status` | **Arquivos modificados** no Git |
| `<leader>gC` | `git_commits` | Histórico de commits |
| `<leader>gb` | `git_branches` | Branches do Git |

### LSP (Navegação e Code Actions)
| Tecla | Ação | Descrição |
|-------|------|-----------|
| `gd` | `definition` | **Ir para definição** |
| `gr` | `references` | Mostrar referências |
| `gi` | `implementation` | Ir para implementação |
| `gt` | `type_definition` | Ir para definição de tipo |
| `K` | `hover` | Mostrar documentação |
| `<leader>ca` | `code_action` | **Code Actions** |
| `<leader>rn` | `rename` | Renomear símbolo |
| `<leader>cf` | `format` | Formatar código |

### LSP com Telescope (Melhor Visualização)
| Tecla | Ação | Descrição |
|-------|------|-----------|
| `<leader>lr` | `lsp_references` | Referências (Telescope) |
| `<leader>ld` | `lsp_definitions` | Definições (Telescope) |
| `<leader>li` | `lsp_implementations` | Implementações (Telescope) |
| `<leader>ls` | `lsp_document_symbols` | Símbolos do documento |
| `<leader>lw` | `lsp_workspace_symbols` | Símbolos do workspace |
| `<leader>lD` | `diagnostics` | Diagnósticos (Telescope) |

### Diagnósticos
| Tecla | Ação | Descrição |
|-------|------|-----------|
| `<leader>e` | `open_float` | Mostrar diagnóstico |
| `[d` | `goto_prev` | Diagnóstico anterior |
| `]d` | `goto_next` | Próximo diagnóstico |
| `<leader>dd` | `open_float` | Mostrar diagnóstico |
| `<leader>da` | `setqflist` | Todos os diagnósticos |

### DAP (Debug)
| Tecla | Ação | Descrição |
|-------|------|-----------|
| `<leader>db` | `toggle_breakpoint` | Toggle breakpoint |
| `<leader>dc` | `continue` | Continuar debug |
| `<leader>do` | `step_over` | Step over |
| `<leader>di` | `step_into` | Step into |
| `<leader>dk` | `hover` | Hover debug info |

**Layout DAP-UI**: Apenas painéis úteis (scopes, breakpoints, stacks, watches) - sem repl/console.

## Como Usar

1. **Reinicie o Neovim** para baixar o vim-test
2. **Abra um arquivo de teste Pest** (`.php`)
3. **Use `<leader>tt`** para executar o teste sob o cursor
4. **Use `<leader>tf`** para executar todos os testes do arquivo

### Navegando com o Terminal Aberto

Quando os testes executam, o terminal abre **verticalmente à direita** (80 colunas). Para navegar:

1. **Layout otimizado**: Código à esquerda, testes à direita
2. **Terminal não entra em modo insert automaticamente** (você pode navegar livremente)
3. **Use `<C-h/j/k/l>`** para navegar entre janelas mesmo no terminal
4. **Use `<Esc>`** se estiver no modo insert do terminal
5. **O tmux-navigator funciona normalmente**

**Simples assim!** Os testes executam no terminal integrado do Neovim. **SEM ERROS!**

## Requisitos

- Neovim nightly
- Docker e Docker Compose configurados
- Arquivo `docker-compose.dev.yml` no diretório raiz do projeto
- Pest instalado no container (`vendor/bin/pest` disponível)

**Simples assim!** Não precisa de volumes especiais ou configurações complexas.

## Troubleshooting

### Se os testes não executarem:
1. Verifique se o container está rodando
2. Teste o comando manualmente: `docker compose -f docker-compose.dev.yml exec -T app vendor/bin/pest`

**Essa configuração usa apenas vim-test (sem neotest). É impossível dar erro!**
