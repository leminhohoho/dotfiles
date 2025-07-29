return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				theme = "center",
				borderchars = {
					results = { " ", " ", "─", "│", "│", " ", "─", "└" },
					prompt = { "─", " ", " ", "│", "┌", "─", " ", "│" },
					preview = { "─", "│", "─", "│", "┬", "┐", "┘", "┴" },
				},
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.5,
					},
				},
				-- Default sorting strategy: descending for most recently used files
				sorting_strategy = "descending", -- You can also experiment with "ascending"
				layout_strategy = "horizontal", -- Layout style (could be vertical or horizontal)
				file_ignore_patterns = { "node_modules", "%.lock", "%.git/", "dist/" },
			},
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--sortr=modified" },
				},
			},
		})
	end,
}
