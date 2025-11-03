return {
	"goerz/jupytext.nvim",
	version = "0.2.0",
	opts = {
		{
			style = "hydrogen",
			output_extension = "auto", -- Default extension. Don't change unless you know what you are doing
			force_ft = { "markdown" }, -- Default filetype. Don't change unless you know what you are doing
			custom_language_formatting = {},
		},
	}, -- see Options
}
