vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/echasnovski/mini.icons",
	"https://github.com/crispgm/telescope-heading.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
})

require("mini.icons").mock_nvim_web_devicons()

local telescope = require("telescope")
local actions = require("telescope.actions")

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

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { silent = true })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { silent = true })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { silent = true })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>", { silent = true })
vim.keymap.set("n", "<Leader>hh", ":Telescope highlights<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fc", function()
	require("telescope.builtin").colorscheme({ enable_preview = true })
end, { silent = true })
