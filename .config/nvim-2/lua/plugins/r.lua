return {
	"R-nvim/R.nvim",
	lazy = false,
	config = function()
		vim.g.R_filetypes = { "r", "rmd", "quarto", "markdown" }
		require("r").setup({
			R_args = { "--quiet", "--no-save" },
			hook = {
				after_config = function()
					vim.api.nvim_set_keymap("n", "<Leader>rf", ":RStart<CR>", { noremap = true })
				end,
			},
		})
	end,
}
