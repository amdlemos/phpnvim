# Neovim Configuration

## Project Overview

This is a Neovim configuration designed for web development. It's built around a modular structure with Lua, and it leverages several popular plugins to provide a modern and feature-rich editing experience.

The configuration is centered around the following key components:

*   **Plugin Management:** Plugins are managed using Neovim's built-in `pack` feature. The configuration is structured to use the `pack/dist/start` and `pack/dist/opt` directories. Plugins in the `start` directory are loaded automatically at startup, while plugins in the `opt` directory are loaded on-demand.

    To add a new plugin, you can add it to the `nvim-pack-lock.json` file and it will be installed automatically.

*   **Plugin Configuration:** Each plugin is configured in its own file in the `plugin/start` directory. The configuration files are named after the plugin they configure (e.g., `telescope.lua` for `telescope.nvim`). This makes it easy to find the configuration for a specific plugin.
*   **Core UI:** The UI is enhanced with `mini.nvim` plugins (`mini.icons`, `mini.pairs`), `nvim-web-devicons`, and a custom set of icons defined in `lua/lib/icons.lua`.
*   **Tmux Integration:** The configuration uses `vim-tmux-navigator` for seamless navigation between Neovim and Tmux panes. It also includes keymaps for navigating between panes.
*   **Diagnostics:** The configuration uses `tiny-inline-diagnostic.nvim` and `trouble.nvim` for displaying diagnostics. It also defines several keymaps for opening and toggling the Trouble UI.
*   **Debugging:** The configuration uses `nvim-dap` and `nvim-dap-ui` for debugging. It's set up with debug adapters for PHP and Dart, and it includes keymaps for controlling the debugger.
*   **Completion:** The configuration uses `blink.cmp` as a completion plugin. It's configured with fuzzy matching, signature help, and a variety of appearance options for the completion menu and documentation. The completion sources are also configured, including LSP, snippets, and buffer text.
*   **File Explorer:** The configuration uses `nvim-tree.lua` as a file explorer. It's configured with a keymap (`<leader>e`) to toggle the file explorer.
*   **Treesitter:** Syntax highlighting and code parsing are handled by `nvim-treesitter`. Note that there are conflicting configurations for syntax highlighting, which may cause unexpected behavior.
*   **LSP:** Language-specific features are provided by `nvim-lspconfig`, with support for PHP (Intelephense), Dart, HTML, CSS, JSON, and more.
*   **Themes:** The configuration includes two themes: `onedark.nvim` and `astrotheme`. `onedark.nvim` is the default theme, and it's configured with the "deep" style, transparency, and other customizations. A keymap (`<leader>tc`) is provided to toggle the theme.
*   **Linting and Formatting:** The configuration uses `none-ls.nvim` to run linters and `conform.nvim` to format code on save. It's set up to work with PHP projects, using tools like `phpcs`, `phpmd`, `phpcbf`, `pint`, and `phpstan`. `conform.nvim` is configured with different formatters for various file types.
*   **Laravel Support:** The configuration includes the `laravel.nvim` plugin, which provides Laravel-specific functionality.
*   **Statusline:** The configuration uses `lualine.nvim` to create a customized statusline with colors, icons, and various components that display information about the buffer, Git, LSP, and more.
*   **Fuzzy Finding:** The configuration uses Telescope as a fuzzy finder and integrates it with other plugins like `frecency`. It also defines a large number of keymaps for finding files, searching, and interacting with Git and the LSP.
*   **Editor Settings:** The configuration includes a variety of settings for Neovim's behavior, including cursor style, indentation, line numbers, and more. It also sets some global variables for plugins like Copilot and netrw.
*   **Keymaps:** Custom keymaps are defined in various files, with the leader key set to the spacebar. The configuration includes a number of keymaps for interacting with the LSP, including navigation, code actions, and diagnostics.

