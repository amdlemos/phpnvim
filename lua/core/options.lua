-- Core Options
-- Configurações globais do Neovim

local opt = vim.opt

-- Editor
opt.guicursor = "i:block"
opt.termguicolors = true
opt.cmdheight = 0
opt.laststatus = 3
opt.winborder = "rounded"

-- Indentação
opt.autoindent = true
opt.smartindent = true
opt.cindent = false
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true

-- Visual
-- opt.colorcolumn = "120"
opt.signcolumn = "yes:1"
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.hlsearch = false
opt.updatetime = 200
opt.lazyredraw = true

-- List chars
opt.listchars = "tab:  ,multispace:|   ,eol:󰌑"
opt.list = false

-- Busca
opt.ignorecase = true
opt.smartcase = true -- Busca case-sensitive se houver maiúsculas

-- Arquivos
opt.swapfile = false
opt.undofile = true
local undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.fn.mkdir(undodir, "p") -- Criar diretório se não existir
opt.undodir = undodir
opt.autoread = true
opt.fileformats = { "unix", "dos" }

-- Clipboard
opt.clipboard = "unnamedplus"

-- Completar
opt.completeopt = { "menuone", "popup", "noinsert" }

-- Comandos
opt.inccommand = "nosplit"
opt.splitright = true
opt.splitbelow = true

-- Variáveis globais
vim.g.copilot_no_tab_map = true
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"
vim.g.loaded_perl_provider = 0
vim.g.php_parent_error = 0

-- Desativar plugins do mini.nvim monolítico que não queremos
vim.g.minigit_disable = true
vim.g.minifiles_disable = true -- Já que você está usando o neo-tree

-- Ativar Neovim Native UI2 (Experimental)
-- Experimental UI2: floating cmdline and messages
-- require("vim._core.ui2").enable({
-- 	enable = true,
-- 	msg = {
-- 		targets = {
-- 			[""] = "msg",
-- 			empty = "cmd",
-- 			bufwrite = "msg",
-- 			confirm = "cmd",
-- 			emsg = "pager",
-- 			echo = "msg",
-- 			echomsg = "msg",
-- 			echoerr = "pager",
-- 			completion = "cmd",
-- 			list_cmd = "pager",
-- 			lua_error = "pager",
-- 			lua_print = "msg",
-- 			progress = "pager",
-- 			rpc_error = "pager",
-- 			quickfix = "msg",
-- 			search_cmd = "cmd",
-- 			search_count = "cmd",
-- 			shell_cmd = "pager",
-- 			shell_err = "pager",
-- 			shell_out = "pager",
-- 			shell_ret = "msg",
-- 			undo = "msg",
-- 			verbose = "pager",
-- 			wildlist = "cmd",
-- 			wmsg = "msg",
-- 			typed_cmd = "cmd",
-- 		},
-- 		cmd = {
-- 			height = 0.5,
-- 		},
-- 		dialog = {
-- 			height = 0.5,
-- 		},
-- 		msg = {
-- 			height = 0.3,
-- 			timeout = 5000,
-- 		},
-- 		pager = {
-- 			height = 0.5,
-- 		},
-- 	},
-- })
