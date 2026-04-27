-- Treesitter Configuration
-- Requer: tree-sitter CLI, gcc/clang, git

require("nvim-treesitter.configs").setup({
    sync_install = false,
    auto_install = true,
    -- Enable Tree-sitter based highlighting. This ensures buffers
    -- opened in Neovim get proper syntax highlighting (not only the
    -- Telescope previewer).
    highlight = {
        enable = true,
        -- Keep vim regex highlighting disabled unless a specific
        -- language requires it. Disable for performance and to avoid
        -- duplicate highlights.
        additional_vim_regex_highlighting = false,
    },
})
