return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		-- vim.filetype.add({
		-- 	extension = {
		-- 		d2 = "d2",
		-- 	},
		-- })

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
				"csv",
				"vue",
				"bash",
				"fish",
				"zig",
				"rasi",
				"gotmpl",
				"sql",
			},
			sync_install = false,
			highlight = { enable = true },
			-- indent = { enable = true },
		})
	end,
}
