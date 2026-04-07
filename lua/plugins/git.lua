-- Custom Git Plugins Configuration

-- Gitsigns: blame inline, hunks, signs na gutter
require("gitsigns").setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	current_line_blame = false, -- toggle com <leader>gB
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 500,
	},
	current_line_blame_formatter = " <author>, <author_time:%d/%m/%Y> · <summary>",
	on_attach = function(bufnr)
		local gs = require("gitsigns")
		local map = function(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
		end

		-- Navegação entre hunks
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, "Próximo hunk")

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, "Hunk anterior")

		-- Ações de hunk
		map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
		map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
		map("v", "<leader>hs", function()
			gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Stage hunk (seleção)")
		map("v", "<leader>hr", function()
			gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Reset hunk (seleção)")
		map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
		map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
		map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
		map("n", "<leader>hu", gs.undo_stage_hunk, "Desfazer stage do hunk")

		-- Blame
		map("n", "<leader>gb", function()
			gs.blame_line({ full = true })
		end, "Blame da linha")
		map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle blame inline")

		-- Diff (gitsigns: diff do arquivo vs index; <leader>gd = DiffviewOpen do projeto)
		map("n", "<leader>gi", gs.diffthis, "Diff do arquivo (index)")
	end,
})

-- Git Conflict: Resolução intuitiva de conflitos
require("git-conflict").setup({
	default_mappings = true, -- Ativa co, ct, cb, etc.
	highlights = {
		incoming = "DiffText",
		current = "DiffAdd",
	},
})

-- Diffview: Interface rica para diffs
require("diffview").setup({
	enhanced_diff_hl = true,
	use_icons = true,
	icons = {
		folder_closed = "",
		folder_open = "",
	},
	signs = {
		fold_closed = "",
		fold_open = "",
		done = "✓",
	},
})
