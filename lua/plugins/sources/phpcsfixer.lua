local null_ls = require("null-ls")
local builtins = null_ls.builtins

return builtins.formatting.phpcsfixer.with({
  prefer_local = "vendor/bin",
})
