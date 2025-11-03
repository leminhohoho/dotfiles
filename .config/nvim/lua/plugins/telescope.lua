return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"echasnovski/mini.icons",
			"crispgm/telescope-heading.nvim",
			opts = {},
			config = function()
				require("mini.icons").mock_nvim_web_devicons()
			end,
		},
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		-- Create a custom layout strategy for ui select
		require("telescope.pickers.layout_strategies").ui_select = function(...)
			local layout = require("telescope.pickers.layout_strategies").horizontal(...)
			layout.prompt.height = layout.prompt.height + 1
			return layout
		end

		telescope.setup({
			defaults = {
				prompt_prefix = "   ",
				borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					width = 0.8,
					height = 0.9,
				},
				layout_strategy = "horizontal",
				theme = "center",
				file_ignore_patterns = { "node_modules", "%.lock", "%.git/", "dist/" },
				mappings = {
					i = {
						["<esc>"] = actions.close,
					},
				},
			},
			pickers = { find_files = { find_command = { "rg", "--files", "--sortr=modified" } } },
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
						layout_strategy = "ui_select",
					}),
				},
			},
		})

		telescope.load_extension("ui-select")
		telescope.load_extension("heading")
	end,
}
