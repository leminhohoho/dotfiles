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
				python = { "black" },
				json = { "jq" },
				css = { "prettierd" },
				d2 = { "d2" },
				zig = { "zigfmt" },
			},

			timeout_ms = 10000,

			formatters = {
				goimports = {
					command = "/home/leminhohoho/go/bin/goimports",
				},
				golines = {
					command = "/home/leminhohoho/go/bin/golines",
					args = { "--max-len=110" },
				},
				jq = {
					-- args = { "-c", "." },
				},
			},
		})
	end,
}
