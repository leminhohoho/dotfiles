vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
vim.cmd([[TSUpdate]])

local languages = {
	"python",
}

require("nvim-treesitter").setup(languages)

vim.api.nvim_create_autocmd("FileType", {
	pattern = languages,
	callback = function()
		vim.treesitter.start()
	end,
})

-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
