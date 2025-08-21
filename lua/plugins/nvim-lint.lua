if true then
	return {}
end
return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("lint").linters.phpcs = {
        cmd = vim.fn.findfile("vendor/bin/phpcs", ".;") or "phpcs"
      }
      
      require("lint").linters_by_ft = {
        php = { "phpcs" }
      }
      
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  }
  -- ... seus outros plugins
}
