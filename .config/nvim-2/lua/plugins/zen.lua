return {
	"folke/zen-mode.nvim",
	opts = {
		window = {
			width = 160,
			options = {
				signcolumn = "no",
				number = false,
				relativenumber = false,
			},
		},
		plugins = {
			tmux = { enabled = true },
		},
	},
}
