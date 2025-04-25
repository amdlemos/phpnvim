return {
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	enabled = true,
	config = function()
		local null_ls = require("null-ls")
		local builtins = null_ls.builtins
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local h = require("null-ls.helpers")

		local twigcs = h.make_builtin({
			name = "docker-twigcs",
			meta = {
				url = "https://github.com/friendsoftwig/twigcs",
				description = "Runs Twigcs in Docker against Twig files.",
			},
			method = null_ls.methods.DIAGNOSTICS,
			filetypes = { "twig" },
			generator_opts = {
				command = "docker-compose",
				args = function(params)
					-- Extrair apenas o nome do arquivo sem o caminho completo
					local filename = vim.fn.fnamemodify(params.bufname, ":t")

					return {
						"exec",
						"-T",
						"web",
						"bash",
						"-c",
						string.format(
							[[
                    content=$(cat)
                    temp_file=$(mktemp -p /tmp %s.XXXXXX)
                    echo "$content" > "$temp_file"
                    WebSocialSaude/vendor/bin/twigcs --reporter json "$temp_file" || true
                    rm "$temp_file"
                ]],
							filename
						),
					}
				end,
				format = "json_raw",
				to_stdin = true,
				check_exit_code = function(code)
					return code <= 1
				end,
				on_output = function(params)
					local output = params.output
					if not output or not output.files or not output.files[1] or not output.files[1].violations then
						return {}
					end

					local violations = output.files[1].violations

					local parser = h.diagnostics.from_json({
						attributes = {
							row = "line",
							col = "column",
							severity = "severity",
							message = "message",
						},
						severities = {
							h.diagnostics.severities["information"],
							h.diagnostics.severities["warning"],
							h.diagnostics.severities["error"],
							h.diagnostics.severities["hint"],
						},
					})

					return parser({ output = violations })
				end,
			},
			factory = h.generator_factory,
		})

		null_ls.register(twigcs)

		null_ls.setup({
			debug = false,
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								async = true,
							})
						end,
					})
				end
			end,
			sources = {

				require("plugins.sources.phpmd").setup(builtins, null_ls.methods.DIAGNOSTICS_ON_SAVE),
				require("plugins.sources.phpstan").setup(builtins, null_ls.methods.DIAGNOSTICS_ON_SAVE),
				require("plugins.sources.phpcs").setup(builtins, null_ls.methods.DIAGNOSTICS_ON_SAVE),
				require("plugins.sources.phpcsfixer").setup(builtins),
				require("plugins.sources.phpcbf").setup(builtins),
				require("plugins.sources.pint").setup(builtins),
				require("plugins.sources.prettier").setup(builtins),
				-- builtins.diagnostics.twigcs.with({
				-- 	-- command = "./bin/twigcs-container.sh",
				-- 	--     args = { "$FILENAME" },
				-- 	command = "docker-compose",
				-- 	args = {
				-- 		"exec",
				-- 		"-T",
				-- 		"web",
				-- 		"WebSocialSaude/vendor/bin/twigcs",
				-- 		"--",
				-- 		"$FILENAME",
				-- 	},
				-- }),
				builtins.formatting.stylua,
				builtins.formatting.xmllint,
				-- builtins.formatting.htmlbeautifier.with({
				-- 	filetypes = { "eruby", "twig" },
				-- }),
			},
		})
	end,
}
