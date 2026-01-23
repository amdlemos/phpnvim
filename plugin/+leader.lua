vim.g.mapleader = " "
vim.keymap.set("n", "<space>", "<Nop>")

vim.opt.fileformats = { "unix", "dos" }
vim.opt.listchars = {
  tab = "»·",
  trail = "·",
  extends = ">",
  precedes = "<",
}
