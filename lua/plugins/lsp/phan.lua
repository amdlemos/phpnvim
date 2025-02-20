local lspconfig = require("lspconfig")

local phan_config_exists = vim.fn.filereadable(vim.fn.getcwd() .. "/.phan/config.php") == 1

if phan_config_exists then
    lspconfig.phan.setup({
        cmd = {
            "vendor/bin/phan",
            "-m",
            "json",
            "--no-color",
            "--no-progress-bar",
            -- "-x",
            -- "-u",
            "-S",
            "--language-server-analyze-only-on-save",
            "--language-server-disable-go-to-definition",
            "--language-server-disable-completion",
            "--language-server-disable-hover",
            "--language-server-on-stdin",
            "--allow-polyfill-parser",
        },
        capabilities = require("blink.cmp").get_lsp_capabilities(),
        settings = {
            phan = {
                files = {
                    maxSize = 9000000,
                },
            },
        },
    })
end
