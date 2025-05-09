return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		keywords = {
			TODO = { icon = " ", color = "info" },
			COMMIT = { icon = " ", color = "github" },
			BACKLOG = { icon = " ", color = "backlog" },
			RNOTE = { icon = " ", color = "info" },
		},

		colors = {
			error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
			warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
			info = { "DapUIScope", "#2563EB" },
			hint = { "DiagnosticHint", "#10B981" },
			default = { "Identifier", "#7C3AED" },
			test = { "Identifier", "#FF00FF" },
			github = { "#ca82e5" },
			backlog = { "#506478" },
		},
	},
}
