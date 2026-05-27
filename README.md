# Neovim Configuration

Configuração modular, minimalista e otimizada do Neovim, focada em desenvolvimento PHP, Web moderno e desempenho.

## Tech Stack
- **Lua nativo**
- **LSP v0.11+** com `vim.lsp.config`
- **Mini.nvim**: Coleção enxuta para UI e fluxo
- **blink.cmp**: Engine de autocompletar rápida

## Plugins

### Core & Utilidades
- `plenary.nvim`: Funções utilitárias Lua
- `nvim-web-devicons`: Ícones (via mini.icons)
- `lazydev.nvim`: Ambiente dev/LSP
- `nvim-nio`: Suporte async

### LSP, Treesitter e Blade
- `nvim-lspconfig`: Configuração LSP
- `nvim-treesitter`: Syntax Highlight, parser
- `blade-nav.nvim`: Navegação em Blade (Laravel)

### UI & Layout
- **Themes**: `onedark.nvim`, `astrotheme`, `tokyonight.nvim`
- `which-key.nvim`: Ajuda de atalhos interativos
- **Mini.nvim**: plugins ativos:
  - `mini.icons`, `mini.statusline`, `mini.tabline`, `mini.indentscope`, `mini.ai`, `mini.bufremove`

### Explorer & Finder
- `neo-tree.nvim`: Explorer modal de arquivos
- `nui.nvim`: Componentes UI
- `telescope.nvim`, `telescope-fzf-native.nvim`, `telescope-ui-select.nvim`: Fuzzy search e seleção UI

### Git & Diff
- `gitsigns.nvim`: Hunks, blame, signs
- `diffview.nvim`: Diffs e histórico do projeto

### Diagnostics & Code Action
- `tiny-inline-diagnostic.nvim`
- `tiny-code-action.nvim`
- `trouble.nvim`
- `edgy.nvim`

### IA e Code Assistant
- `sidekick.nvim`: Assistente IA (padrão)
- `copilot.lua`, `blink.cmp`, `blink-cmp-copilot`: Auto-completar IA

### Completion
- `blink.cmp`: Engine principal
- `friendly-snippets`: Coleção de snippets
- `lspkind.nvim`: Ícones nas sugestões

### Ferramentas & Format
- `conform.nvim`: Formatter
- `vim-tmux-navigator`: Integração tmux/nvim

### Debug & Testes
- `nvim-dap`, `nvim-dap-ui`: Depuração
- `neotest`, `neotest-phpunit`, `neotest-pest`: Test runner native

### Markdown
- `render-markdown.nvim`: Preview/Render Markdown

### Database
- `vim-dadbod`, `vim-dadbod-ui`, `vim-dadbod-completion`: Ferramentas SQL
