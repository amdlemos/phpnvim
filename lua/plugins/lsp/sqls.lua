local M = {}

M.setup = function(lspconfig)
	return lspconfig.sqls.setup({
 cmd = {
                    "sqls",
                    "-log",
                    os.getenv("HOME").."/sqls.log",
                    "-config",
                    os.getenv("HOME").."/.config/sqls/config.yml",
                },
                -- cmd = { 'sqls', '-config', os.getenv("HOME") .. '/.config/sqls/config.yml' },
                settings = {
                    sqls = {
                        connections = {
                            {
                                driver = "mysql",
                                dataSourceName = "root:root@tcp(127.0.0.1:13306)/world",
                            },
                            {
                                driver = "postgresql",
                                dataSourceName =
                                "host=127.0.0.1 port=15432 user=postgres password=mysecretpassword1234 dbname=dvdrental sslmode=disable",
                            },
                        },
                    },
                },
  })
end
