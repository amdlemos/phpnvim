# 🚀 Neovim Configuration

Minimalist, modular, and fast Neovim setup optimized for PHP, Vue, and modern Web Development.

## 🛠️ Tech Stack & Core
- **Native Lua Config**: Structured and clean.
- **Native LSP (v0.11+)**: Optimized with `vim.lsp.config`.
- **Mini.nvim**: Core collection for UI and functional modules.
- **Blink.cmp**: Super fast completion engine.

## 📦 Plugins

### Core & Dependencies
- `plenary.nvim`: Utility functions.
- `nvim-web-devicons`: Icons support (emulated by `mini.icons`).
- `lazydev.nvim`: Workspace/LSP development.

### LSP & Treesitter
- `nvim-lspconfig`: Server configurations.
- `nvim-treesitter`: Syntax highlighting.
- `blade-nav.nvim`: Laravel Blade navigation.

### UI & Layout
- `onedark.nvim` / `astrotheme`: Color schemes.
- `which-key.nvim`: Command shortcuts helper.
- **Mini Modules**:
  - `mini.files`: Modal file explorer.
  - `mini.statusline`: Fast statusline.
  - `mini.tabline`: Minimalist tabs.
  - `mini.icons`: Unified icon management.
  - `mini.indentscope`: Indent indicators.
  - `mini.ai`: Enhanced text objects.

### Git & Conflict Resolution
- `diffview.nvim`: Rich diffs and history.
- `git-conflict.nvim`: Merge resolution.
- `mini.diff` / `mini.git`: Buffer signs, hunk management, and commit flow.

### Development Tools
- `fzf-lua`: Fuzzy search (files, grep, symbols).
- `conform.nvim`: Auto-formatting.
- `nvim-dap` / `nvim-dap-ui`: Debugging.
- `neotest`: Native testing framework.

### Completions & AI
- `blink.cmp`: Core completion engine.
- `copilot.lua`: GitHub Copilot integration.
- `friendly-snippets`: Snippets collection.

---
*Created with ❤️ for performance.*
