vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

local home = vim.fn.expand("~")

require("conform").setup({
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
		css = { "prettierd" },
		zig = { "zigfmt" },
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

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		local filetype = vim.bo.filetype

		-- NOTE: using lsp built in formatter for certain language for faster speed
		if filetype == "go" or filetype == "zig" then
			vim.lsp.buf.format()
		else
			require("conform").format({ bufnr = args.buf })
		end
	end,
})
