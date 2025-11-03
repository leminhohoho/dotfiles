return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = function()
		local noice = require("noice")

		noice.setup({
			cmdline = {
				enabled = true,
				view = "cmdline_popup",
				format = {
					cmdline = { pattern = "^:", icon = ">_", lang = "vim" },
					input = { view = "cmdline_input", icon = "󰝤 " },
				},
			},
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
				{
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = {
						skip = true,
					},
				},
			},
			views = {
				cmdline_popup = {
					border = {
						style = "none",
						padding = { 1, 2 },
					},
				},
				cmdline_input = {
					view = "cmdline_popup",
					border = {
						padding = { 0, 1 },
					},
				},
			},
		})
	end,
}
