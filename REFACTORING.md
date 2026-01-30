# Refatoração da Configuração do Neovim

## 📁 Nova Estrutura

```
nvim/
├── init.lua                    # Ponto de entrada - orquestra os módulos
├── lua/
│   ├── core/
│   │   ├── options.lua         # Opções globais do Neovim
│   │   ├── keymaps.lua         # Keymaps globais (não específicos de plugins)
│   │   ├── autocmds.lua        # Autocomandos globais
│   │   └── plugins.lua         # ⚠️ ÚNICO ponto de vim.pack.add
│   ├── plugins/               # Configurações de plugins
│   │   ├── telescope.lua
│   │   ├── treesitter.lua
│   │   ├── lualine.lua
│   │   └── ...
│   └── lsp/
│       ├── init.lua           # Inicialização do LSP
│       ├── capabilities.lua  # Capabilities compartilhadas
│       ├── on_attach.lua      # Função on_attach centralizada
│       ├── keymaps.lua        # Keymaps globais de LSP
│       └── servers/           # Configurações individuais de servidores
│           ├── intelephense.lua
│           ├── phpactor.lua
│           ├── tailwindcss.lua
│           └── ...
└── plugin/                     # ⚠️ DEPRECATED - pode ser removida
```

## 🎯 Princípios da Nova Estrutura

### 1. **Separação de Responsabilidades**

- **`core/`**: Configurações fundamentais do Neovim (options, keymaps globais, autocmds)
- **`plugins/`**: Apenas configuração/setup de plugins (sem `vim.pack.add`)
- **`lsp/`**: Toda a lógica relacionada ao LSP

### 2. **Único Ponto de Declaração de Plugins**

- **`core/plugins.lua`** é o ÚNICO arquivo que pode chamar `vim.pack.add`
- Nenhum outro arquivo deve declarar plugins
- Isso evita duplicação e facilita manutenção

### 3. **LSP Organizado**

- `capabilities` compartilhadas para todos os servidores
- `on_attach` centralizado com keymaps de LSP
- Um arquivo por servidor em `lsp/servers/`
- Sem lógica de plugin misturada com LSP

### 4. **Fluxo de Carregamento**

```
init.lua
  ├── core/options.lua
  ├── core/keymaps.lua
  ├── core/autocmds.lua
  ├── core/plugins.lua (vim.pack.add)
  ├── plugins/*.lua (configurações)
  └── lsp/init.lua
```

## 📝 Como Adicionar um Novo Plugin

### 1. Adicionar em `core/plugins.lua`

```lua
vim.pack.add({
  { src = "https://github.com/usuario/plugin.nvim" },
}, { load = true })
```

### 2. Criar arquivo de configuração em `plugins/`

```lua
-- lua/plugins/meu-plugin.lua
require("meu-plugin").setup({
  -- configurações
})
```

O arquivo será carregado automaticamente pelo `init.lua`.

## 📝 Como Adicionar um Novo Servidor LSP

### 1. Criar arquivo em `lsp/servers/`

```lua
-- lua/lsp/servers/meu-lsp.lua
return {
  settings = {
    -- configurações específicas
  },
}
```

### 2. Adicionar na lista de servidores habilitados

Editar `lua/lsp/init.lua` e adicionar `"meu-lsp"` na lista `enabled_servers`.

## 🚀 Migração da Pasta `plugin/`

A pasta `plugin/` antiga pode ser removida ou renomeada para backup:

```bash
# Fazer backup
mv ~/.config/nvim/plugin ~/.config/nvim/plugin.backup

# Ou remover (após verificar que tudo funciona)
rm -rf ~/.config/nvim/plugin
```

## ✅ Checklist de Migração

- [x] Estrutura de pastas criada
- [x] `init.lua` criado
- [x] `core/plugins.lua` centralizado
- [x] Options, keymaps e autocmds migrados
- [x] Estrutura LSP completa
- [x] Configurações de plugins migradas
- [ ] Testar configuração
- [ ] Remover/backup da pasta `plugin/` antiga

## 🔍 Onde Ficou Cada Coisa

### De `plugin/configs.lua` → `lua/core/options.lua`
### De `plugin/keymaps.lua` → `lua/core/keymaps.lua`
### De `plugin/autocmds.lua` → `lua/core/autocmds.lua`
### De `plugin/lsp.lua` + `plugin/lsp-keymaps.lua` → `lua/lsp/`
### De `plugin/*.lua` (configurações) → `lua/plugins/*.lua`
### De `lsp/tailwindcss.lua` → `lua/lsp/servers/tailwindcss.lua`

## 🎨 Boas Práticas

1. **Não usar `vim.pack.add` fora de `core/plugins.lua`**
2. **Manter configurações de plugins separadas** (um arquivo por plugin)
3. **Usar `on_attach` padrão** a menos que o servidor precise de customização
4. **Documentar configurações não óbvias** com comentários
5. **Manter keymaps organizados** por contexto (core, plugins, lsp)
