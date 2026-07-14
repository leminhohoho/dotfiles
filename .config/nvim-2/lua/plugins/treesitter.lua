return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = {
					"python",
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"elixir",
					"heex",
					"javascript",
					"html",
					"typescript",
					"go",
					"markdown",
					"markdown_inline",
					"latex",
					"templ",
					"http",
					"vue",
					"bash",
					"fish",
					"zig",
					"rasi",
					"gotmpl",
					"sql",
					"bash",
					"fish",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = false },
			})
		end,
	},
	{
		"ravsii/tree-sitter-d2",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		build = "make nvim-install",
	},
}
