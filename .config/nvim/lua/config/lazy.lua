-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ { import = "plugins" }, { import = "plugins.lsp" } },
		-- ESSENTIAL PLUGINS HERE --
		{
			"projekt0n/github-nvim-theme",
			priority = 1000,
			config = function()
				vim.cmd("colorscheme github_dark_default")
			end,
		},
		{
			"christoomey/vim-tmux-navigator",
			cmd = {
				"TmuxNavigateLeft",
				"TmuxNavigateDown",
				"TmuxNavigateUp",
				"TmuxNavigateRight",
				"TmuxNavigatePrevious",
				"TmuxNavigatorProcessList",
			},
			keys = {
				{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
				{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
				{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
				{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
				{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
			},
		},
		{
			"rmagatti/auto-session",
			config = function()
				local auto_session = require("auto-session")

				auto_session.setup({
					auto_restore_enabled = false,
				})
			end,
		},
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local telescope = require("telescope")

				telescope.setup({
					defaults = {
						-- Default sorting strategy: descending for most recently used files
						sorting_strategy = "descending", -- You can also experiment with "ascending"
						layout_strategy = "horizontal", -- Layout style (could be vertical or horizontal)
						file_sorter = require("telescope.sorters").get_fuzzy_file, -- Default fuzzy sorter
						file_ignore_patterns = { "node_modules", "%.lock", "%.git/", "dist/" },
					},
				})
			end,
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
