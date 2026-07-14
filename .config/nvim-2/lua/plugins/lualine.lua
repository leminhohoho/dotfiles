return {
	"nvim-lualine/lualine.nvim",
	opts = {},
	dependencies = { "echasnovski/mini.icons" },

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
				theme = "gruvbox_dark",
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
						sources = { "nvim_lsp" },
						sections = { "error", "warn" },
						symbols = {
							error = " ",
							warn = " ",
							info = " ",
							hint = " ",
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
			},
		})
	end,
}
