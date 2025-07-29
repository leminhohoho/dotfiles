return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local obsidian = require("obsidian")

		obsidian.setup({
			templates = {
				folder = "templates",
			},
			workspaces = {
				{
					name = "linux",
					path = "~/note-taking/Elastikos",
					overrides = {
						daily_notes = {
							folder = "daily notes",
						},
					},
				},
				{
					name = "note",
					path = "~/note-taking/Monadikos",
					overrides = {
						daily_notes = {
							folder = "daily notes",
						},
					},
				},
			},
			completion = {
				blink = true,
			},
			ui = { enable = false },
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				-- vim.fn.jobstart({ "open", url }) -- Mac OS
				vim.fn.jobstart({ "xdg-open", url }) -- linux
				-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
				-- vim.ui.open(url) -- need Neovim 0.10.0+
			end,
		})
	end,
}
