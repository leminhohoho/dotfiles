return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		image = {
			doc = {
				max_width = 80,
				max_height = 80,
			},
			math = {
				enabled = true,
			},
		},
		-- picker = { enabled = true },
		flash = { enabled = true },
	},
}
