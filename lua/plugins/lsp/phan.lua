local lspconfig = require("lspconfig")

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
