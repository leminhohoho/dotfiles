return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		image = {
			doc = {
				max_width = 120,
				max_height = 120,
			},
			math = {
				enabled = false,
			},
		},
		-- picker = { enabled = true },
		flash = { enabled = true },
	},
}
