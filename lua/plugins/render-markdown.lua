-- Render Markdown Configuration
-- Renderização de markdown no Neovim (inclui suporte ao codecompanion)

require("render-markdown").setup({
	file_types = { "markdown", "codecompanion" },
})
