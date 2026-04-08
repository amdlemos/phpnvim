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
opt.cindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true

-- Visual
opt.colorcolumn = "120"
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
