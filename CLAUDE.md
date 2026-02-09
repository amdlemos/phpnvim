# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal Neovim configuration targeting **Neovim nightly (v0.12+)**. Written entirely in Lua, using the native `vim.pack` API for plugin management (no lazy.nvim or packer). Primary languages: PHP (Laravel/Sail), TypeScript/JavaScript, Dart/Flutter.

## Architecture

### Loading order (init.lua)

1. `core/options.lua` - vim options (4-space tabs, space leader)
2. `core/keymaps.lua` - global keymaps
3. `core/autocmds.lua` - autocommands
4. `core/plugins.lua` - **the ONLY file that calls `vim.pack.add`**
5. `plugins/*.lua` - auto-loaded by iterating `lua/plugins/` directory
6. `lsp/init.lua` - LSP setup

### Key constraint: single plugin declaration point

All plugins are declared in `core/plugins.lua` via `vim.pack.add()`. Plugin configuration files in `lua/plugins/` must **never** call `vim.pack.add` — they only call `require("plugin-name").setup({...})` and define keymaps.

### LSP structure (`lua/lsp/`)

- `init.lua` - iterates `enabled_servers` list, loads per-server config from `lsp/servers/`, applies shared capabilities and on_attach
- `capabilities.lua` - shared LSP capabilities
- `on_attach.lua` - default on_attach function with buffer-local keymaps (gd, gr, gi, K, etc.)
- `keymaps.lua` - global diagnostic keymaps (`<leader>d` group)
- `servers/<name>.lua` - each returns a table merged into the server config. If it includes an `on_attach`, that replaces the default

Uses `vim.lsp.config()` + `vim.lsp.enable()` (native Neovim 0.11+ API), not lspconfig's `setup()`.

### Adding a new plugin

1. Add `{ src = "https://github.com/..." }` to `core/plugins.lua`
2. Create `lua/plugins/<name>.lua` with setup and keymaps (auto-loaded)

### Adding a new LSP server

1. Create `lua/lsp/servers/<name>.lua` returning a config table
2. Add the server name to `enabled_servers` in `lua/lsp/init.lua`

## Notable conventions

- Comments and keymap descriptions are in **Brazilian Portuguese**
- Leader key is `<Space>`
- Formatting on save via conform.nvim (stylua for Lua, prettier for HTML/JSON/YAML, biome for TS, php_cs_fixer for PHP, blade_formatter for Blade)
- FZF-lua is the primary fuzzy finder (replaces Telescope); it overrides `gd`, `gr`, `gi` to route through FZF
- Testing uses neotest + neotest-phpunit running through **Laravel Sail** (`vendor/bin/sail test`), with container-to-host path mapping for JUnit XML results
- DAP configured for PHP (Xdebug) and Dart/Flutter
- There is also a top-level `lsp/tailwindcss.lua` (Neovim's native `lsp/` directory for vim.lsp.config) separate from `lua/lsp/servers/tailwindcss.lua`

## Useful commands

```bash
# Check config for errors
nvim --headless +"lua print('ok')" +qa

# Sync plugins (vim.pack downloads on first use)
# Just restart Neovim - vim.pack.add with load=true handles it

# Format Lua files
stylua lua/
```
