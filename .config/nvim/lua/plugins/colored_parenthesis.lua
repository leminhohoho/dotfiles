return {
	"HiPhish/rainbow-delimiters.nvim",
	config = function()
		-- This module contains a number of default definitions
		local rainbow_delimiters = require("rainbow-delimiters")

		---@type rainbow_delimiters.config
		vim.g.rainbow_delimiters = {
			blacklist = {
				"html","lua"
			},
			strategy = {
				[""] = rainbow_delimiters.strategy["global"],
				vim = rainbow_delimiters.strategy["local"],
			},
			query = {
				[""] = "rainbow-delimiters",
				lua = "rainbow-blocks",
			},
			priority = {
				[""] = 110,
				lua = 210,
			},
			highlight = {
				-- 'RainbowDelimiterRed',
				"ParenBlue",
				"ParenYellow",
				"ParenGreen",
				"ParenLightPink",
				"ParenPink",
				"ParenPurple",
			},
		}
	end,
}
