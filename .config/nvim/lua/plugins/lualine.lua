local colors = {
	black = "#282828",
	white = "#ebdbb2",
	red = "#fb4934",
	green = "#3FBA50",
	blue = "#58A6FF",
	yellow = "#D29922",
	purple = "#D2A8FF",
	gray = "#8B949E",
	darkgray = "#3c3836",
	lightgray = "#504945",
	inactivegray = "#7c6f64",
	transparent = "#00FFFFFF",
}

local theme = {
	normal = {
		a = { bg = colors.blue, fg = colors.black },
		b = { bg = colors.transparent, fg = colors.blue },
		c = { bg = colors.transparent, fg = colors.blue },
	},
	insert = {
		a = { bg = colors.green, fg = colors.black },
		b = { bg = colors.transparent, fg = colors.green },
		c = { bg = colors.transparent, fg = colors.green },
	},
	visual = {
		a = { bg = colors.yellow, fg = colors.black },
		b = { bg = colors.transparent, fg = colors.yellow },
		c = { bg = colors.transparent, fg = colors.yellow },
	},
	replace = {
		a = { bg = colors.red, fg = colors.black },
		b = { bg = colors.transparent, fg = colors.red },
		c = { bg = colors.transparent, fg = colors.red },
	},
	command = {
		a = { bg = colors.purple, fg = colors.black },
		b = { bg = colors.transparent, fg = colors.purple },
		c = { bg = colors.transparent, fg = colors.purple },
	},
	inactive = {
		a = { bg = colors.transparent, fg = colors.gray },
		b = { bg = colors.darkgray, fg = colors.gray },
		c = { bg = colors.transparent, fg = colors.gray },
	},
}

return {
	"nvim-lualine/lualine.nvim",
	opts = {},
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		require("lualine").setup({
			options = {
				component_separators = { left = "", right = "" },
				section_separators = { left = "  ", right = "  " },
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
					{
						"diff",
					},
					{
						"diagnostics",
						sources = { "nvim_lsp" }, -- Use LSP diagnostics
						sections = { "error", "warn" }, -- Show errors and warnings
						symbols = {
							error = " ", -- Error symbol
							warn = " ", -- Warning symbol
							info = " ", -- Info symbol (optional)
							hint = " ", -- Hint symbol (optional)
						},
					},
				},
				lualine_c = {
					{
						"filename",
						path = 1,
					},
				},
				lualine_x = { "filetype" },
				lualine_y = {},
			},
		})
	end,
}
