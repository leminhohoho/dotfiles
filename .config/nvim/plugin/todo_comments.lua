vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/folke/todo-comments.nvim",
})

require("todo-comments").setup({
	keywords = {
		TODO = { icon = " ", color = "info" },
		ERROR = { icon = " ", color = "error" },
		FATAL = { icon = " ", color = "error" },
	},

	colors = {
		error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
		warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
		info = { "DapUIScope", "#2563EB" },
		hint = { "DiagnosticHint", "#10B981" },
		default = { "Identifier", "#7C3AED" },
		test = { "Identifier", "#FF00FF" },
	},
})

vim.keymap.set("n", "<leader>td", ":TodoTelescope<CR>", { silent = true })
