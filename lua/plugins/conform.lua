return {
	"stevearc/conform.nvim",
	opts = {},
	enabled = true,
	config = function()
		local conform = require("conform")
		conform.setup({
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 500,
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				twig = { "ludtwig", "twig_cs_fixer" },
			},
			formatters = {
				ludtwig = {
					inherit = false,
					command = "ludtwig",
					args = { "-f", "$FILENAME" },
					stdin = false,
				},
				twig_cs_fixer = {
					command = "docker-compose",
					args = function(self, ctx)
						-- Extrair apenas o nome do arquivo sem o caminho completo
						local filename = vim.fn.fnamemodify(ctx.filename, ":t")

						return {
							"exec",
							"-T",
							"web",
							"bash",
							"-c",
							string.format(
								[[
            temp_file=$(mktemp -p /tmp %s.XXXXXX)
            cat > "$temp_file"
            # Substitua o comando abaixo pelo comando real do seu twig-cs-fixer
            WebSocialSaude/vendor/bin/twig-cs-fixer fix "$temp_file" --no-backup
            cat "$temp_file"
            rm "$temp_file"
          ]],
								filename
							),
						}
					end,
					stdin = true,
					require_cwd = false,
				},
			},
		})
	end,
}
