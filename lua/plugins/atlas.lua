-- Atlas: Pull Requests e Issues do GitHub dentro do Neovim
-- Autenticação via GitHub CLI: `gh auth login`
-- Verificar setup com :checkhealth atlas

require("atlas").setup({
	pulls = {
		diff = {
			open_cmd = "AtlasDiff",
			layout = "side-by-side",
			compact = true,
			explorer = {
				grouped = true,
				show_commits = true,
				width = 40,
				initial_focus = "explorer",
			},
		},
		providers = {
			github = {
				cache_ttl = 300,
				views = {
					{ name = "Meus PRs", key = "1", layout = "plain", search = "author:@me sort:updated-desc" },
					{
						name = "Review pedido",
						key = "2",
						layout = "plain",
						search = "is:pr is:open review-requested:@me",
					},
					{ name = "Abertos", key = "3", layout = "plain", search = "is:pr is:open sort:updated-desc" },
				},
				bookmarks = {
					key = "S",
					label = "Buscar",
					items = {
						["Rascunhos"] = "is:pr is:draft author:@me",
						["Mencionam eu"] = "is:pr is:open mentions:@me",
						["Merged recentes"] = "is:pr is:merged author:@me sort:updated-desc",
					},
				},
			},
		},
	},

	issues = {
		max_results = 100,
		with_relationships = true,
		providers = {
			github = {
				cache_ttl = 300,
				views = {
					{ name = "Atribuídas a mim", key = "1", layout = "plain", search = "assignee:@me is:open" },
					{ name = "Criadas por mim", key = "2", layout = "plain", search = "author:@me is:open" },
					{ name = "Abertas", key = "3", layout = "plain", search = "is:issue is:open sort:updated-desc" },
				},
				bookmarks = {
					key = "S",
					label = "Buscar",
					items = {
						["Bugs"] = "is:issue is:open label:bug",
						["Good first issue"] = 'is:issue is:open label:"good first issue"',
						["Mencionam eu"] = "is:issue is:open mentions:@me",
					},
				},
			},
		},
	},
})

-- Diff local (staged / unstaged) dentro do AtlasDiff.
--
-- AtlasDiff só aceita `base...head` onde os dois lados resolvem para um commit
-- (ver atlas.nvim: lua/atlas/pulls/diff/atlas/git.lua, funcao resolve_range).
-- O índice e a working tree não são commits, então criamos dois commits soltos
-- (dangling), sem mexer em nenhuma branch, no índice real ou nos arquivos:
--
--   commit_indice    = árvore do índice atual, com HEAD como pai
--   commit_worktree  = árvore da working tree, com commit_indice como pai
--
-- Como AtlasDiff usa `git merge-base` entre os dois lados, encadear os pais
-- desse jeito faz cada intervalo isolar exatamente o que se quer:
--
--   HEAD...commit_indice            = staged      (igual a `git diff --cached`)
--   commit_indice...commit_worktree = unstaged    (igual a `git diff`)
--   HEAD...commit_worktree          = staged + unstaged (igual a `git diff HEAD`)
--
-- Os commits soltos ficam sem referência e são removidos pelo `git gc` depois.

local function run_git(args, opts)
	opts = opts or {}
	local cmd = { "git" }
	vim.list_extend(cmd, args)
	local result = vim.system(cmd, { text = true, cwd = opts.cwd, env = opts.env }):wait()
	if result.code ~= 0 then
		return nil, vim.trim(result.stderr or "")
	end
	return vim.trim(result.stdout or "")
end

---Cria os commits soltos que representam índice e working tree.
---@return table|nil revisoes, string|nil erro
local function build_local_revisions()
	local root, root_err = run_git({ "rev-parse", "--show-toplevel" })
	if not root then
		return nil, "não é um repositório git: " .. tostring(root_err)
	end

	local git_dir = run_git({ "rev-parse", "--absolute-git-dir" }, { cwd = root })
	if not git_dir then
		return nil, "não foi possível localizar o diretório .git"
	end

	if not run_git({ "rev-parse", "--verify", "--quiet", "HEAD" }, { cwd = root }) then
		return nil, "repositório sem commits (HEAD não existe)"
	end

	local index_tree, index_tree_err = run_git({ "write-tree" }, { cwd = root })
	if not index_tree then
		return nil, "git write-tree falhou: " .. tostring(index_tree_err)
	end

	local index_commit, index_commit_err = run_git(
		{ "commit-tree", index_tree, "-p", "HEAD", "-m", "atlas: índice (staged)" },
		{ cwd = root }
	)
	if not index_commit then
		return nil, "git commit-tree do índice falhou: " .. tostring(index_commit_err)
	end

	-- Índice temporário: `git add -A` roda contra a cópia, o índice real não muda.
	-- `-A` (em vez de `-u`) inclui arquivos untracked no diff unstaged.
	-- Arquivos cobertos por .gitignore continuam de fora.
	local temp_index = vim.fn.tempname()
	if not vim.uv.fs_copyfile(git_dir .. "/index", temp_index) then
		return nil, "não foi possível copiar o índice do git"
	end

	local temp_env = { GIT_INDEX_FILE = temp_index }
	local _, add_err = run_git({ "add", "-A" }, { cwd = root, env = temp_env })
	local worktree_tree, worktree_tree_err = run_git({ "write-tree" }, { cwd = root, env = temp_env })
	vim.uv.fs_unlink(temp_index)

	if add_err and add_err ~= "" then
		return nil, "git add -A falhou: " .. add_err
	end
	if not worktree_tree then
		return nil, "git write-tree da working tree falhou: " .. tostring(worktree_tree_err)
	end

	local worktree_commit, worktree_commit_err = run_git(
		{ "commit-tree", worktree_tree, "-p", index_commit, "-m", "atlas: working tree (unstaged)" },
		{ cwd = root }
	)
	if not worktree_commit then
		return nil, "git commit-tree da working tree falhou: " .. tostring(worktree_commit_err)
	end

	return {
		root = root,
		staged = "HEAD..." .. index_commit,
		unstaged = index_commit .. "..." .. worktree_commit,
		all = "HEAD..." .. worktree_commit,
	}
end

---@param kind "staged"|"unstaged"|"all"
---@param label string
local function open_local_diff(kind, label)
	local revisions, err = build_local_revisions()
	if not revisions then
		vim.notify("[Atlas] " .. err, vim.log.levels.ERROR)
		return
	end

	local range = revisions[kind]
	local changed = run_git({ "diff", "--name-only", range }, { cwd = revisions.root })
	if changed == "" then
		vim.notify("[Atlas] Nenhuma alteração " .. label, vim.log.levels.INFO)
		return
	end

	vim.cmd("AtlasDiff " .. range)
end

vim.api.nvim_create_user_command("AtlasDiffStaged", function()
	open_local_diff("staged", "staged")
end, { desc = "AtlasDiff: staged vs HEAD" })

vim.api.nvim_create_user_command("AtlasDiffUnstaged", function()
	open_local_diff("unstaged", "unstaged")
end, { desc = "AtlasDiff: working tree vs índice" })

vim.api.nvim_create_user_command("AtlasDiffLocal", function()
	open_local_diff("all", "local")
end, { desc = "AtlasDiff: staged + unstaged vs HEAD" })

-- Keymaps: prefixo <leader>a (Atlas)
local map = function(lhs, rhs, desc)
	vim.keymap.set("n", lhs, rhs, { desc = desc })
end

map("<leader>ap", "<cmd>AtlasPulls github<cr>", "Atlas: Pull Requests")
map("<leader>ai", "<cmd>AtlasIssues github<cr>", "Atlas: Issues")
map("<leader>as", "<cmd>AtlasSearch github<cr>", "Atlas: Buscar")
map("<leader>aP", "<cmd>AtlasCreatePR<cr>", "Atlas: Criar PR")
map("<leader>aI", "<cmd>AtlasCreateIssue<cr>", "Atlas: Criar Issue")
map("<leader>an", "<cmd>AtlasNotes<cr>", "Atlas: Notas de review")
map("<leader>ad", "<cmd>AtlasDiff<cr>", "Atlas: Diff")
map("<leader>aS", "<cmd>AtlasDiffStaged<cr>", "Atlas: Diff staged vs HEAD")
map("<leader>au", "<cmd>AtlasDiffUnstaged<cr>", "Atlas: Diff unstaged (working tree vs índice)")
map("<leader>aw", "<cmd>AtlasDiffLocal<cr>", "Atlas: Diff staged + unstaged vs HEAD")
map("<leader>aC", "<cmd>AtlasClearCache<cr>", "Atlas: Limpar cache")
map("<leader>al", "<cmd>AtlasLogs<cr>", "Atlas: Logs")
