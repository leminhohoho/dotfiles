vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })

require("colorizer").setup({
	options = {
		parsers = {
			hex = {
				rrggbb = true,
				rrggbbaa = true,
				hash_aarrggbb = true,
			},
		},
		display = {
			mode = "virtualtext",
			virtualtext = {
				char = "■",
				position = "before",
			},
		},
	},
})
