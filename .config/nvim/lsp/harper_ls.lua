return {
	cmd = { "harper-ls", "--stdio" },
	filetypes = { "markdown", "text", "tex", "typst" },
	settings = {
		["harper-ls"] = {
			linters = {
				LongSentences = false,
				Spaces = false,
			},
		},
	},
}
