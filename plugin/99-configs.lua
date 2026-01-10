local opt = vim.opt
opt.guicursor = "i:block"
opt.colorcolumn = "120"
opt.signcolumn = "yes:1"
opt.termguicolors = true
opt.ignorecase = true
opt.swapfile = false
opt.autoindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true
opt.listchars = "tab: ,multispace:|   ,eol:󰌑"
opt.list = false
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.wrap = false
opt.cursorline = true
opt.scrolloff = 8
opt.inccommand = "nosplit"
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.completeopt = { "menuone", "popup", "noinsert" }
opt.winborder = "rounded"
opt.hlsearch = false
opt.cmdheight = 0
opt.clipboard = "unnamedplus" -- neovim uses the system clipboard by default

vim.cmd.filetype("plugin indent on")
-- vim.cmd.colorscheme("techbase")

vim.g.copilot_no_tab_map = true
vim.g.netrw_liststyle = 1
vim.g.netrw_sort_by = "size"
vim.g.loaded_perl_provider = 0
-- vim.g.blade_php_highlight = 1
-- vim.g.php_parent_error = 0
