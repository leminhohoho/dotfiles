local home = vim.fn.expand("~")

return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				templ = { "templ" },
				lua = { "stylua" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				go = { "goimports", "golines" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				python = { "ruff_format" },
				json = { "jq" },
				css = { "prettier" },
				html = { "prettierd" },
				zig = { "zigfmt" },
				-- sql = { "sql_formatter" },
			},

			timeout_ms = 10000,

			formatters = {
				goimports = {
					command = home .. "/go/bin/goimports",
				},
				golines = {
					command = home .. "/go/bin/golines",
					args = { "--max-len=150" },
				},
				black = {
					args = { "--line-length", "150", "--quiet", "-" },
				},
				ruff = {
					args = {},
				},
				sqlfluff = {
					command = home .. "/.local/bin/sqlfluff",
					args = { "format", "--dialect=sqlite", "-" },
					stdin = true,
				},
				sql_formatter = {
					command = "/usr/local/bin/sql-formatter",
					args = {
						"--language",
						"sqlite",
						"--config",
						home .. "/.sql-formatter.json",
					},
					stdin = true,
				},
			},
		})
	end,
}

