local null_ls = require("null-ls")
local builtins = null_ls.builtins

return builtins.diagnostics.phpcs.with({
  prefer_local = "vendor/bin",
  method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
})
