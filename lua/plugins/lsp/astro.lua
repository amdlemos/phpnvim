local bin_path = vim.fn.getcwd() .. "/node_modules/.bin/"
local M = {}

M.setup = function(lspconfig, capabilities)
  lspconfig.astro.setup({
    capabilities = capabilities,
    -- cmd = { bin_path .. "astro-ls", "--stdio" },
  })
end

return M
