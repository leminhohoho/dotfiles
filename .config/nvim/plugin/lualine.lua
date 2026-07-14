vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })

local theme = require("lualine.themes.gruvbox_dark")
theme.normal.c.bg = "none"
theme.normal.c.bg = "none"
theme.insert.c.bg = "none"
theme.visual.c.bg = "none"
theme.replace.c.bg = "none"
theme.replace.c.bg = "none"
theme.command.c.bg = "none"
theme.inactive.c.bg = "none"

require("lualine").setup({
	options = {
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		refresh = {
			statusline = 50,
			tabline = 50,
			winbar = 50,
		},
		theme = theme,
	},
	sections = {
		lualine_b = {
			{
				"branch",
				icon = "",
			},
			"diff",
		},
		lualine_c = {
			{
				"filename",
				path = 1,
			},
			{
				"diagnostics",
				sections = { "error", "warn", "hint" },
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
		},
		lualine_x = { "filetype" },
		lualine_y = {},
	},
})
