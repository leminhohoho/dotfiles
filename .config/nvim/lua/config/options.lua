vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 19
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.copyindent = true
vim.o.autoread = true
vim.o.showmode = false
vim.o.smoothscroll = true
vim.o.autoread = true

-- NETRW CUSTOMIZATION --
-- Keep netrw in 1 buffer instead of switching to different ones as entering directories
vim.cmd("let g:netrw_liststyle = 3")

-- Remove netrw banner --
vim.g.netrw_banner = 0

-- Show directories first (sorting)
vim.g.netrw_sort_sequence = [[[\/]$,*]]

-- MISCELLANEOUS --
-- Set line breaks to preserve words
vim.cmd("set linebreak")

-- LSP diagnostic configuration for real-time updates
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = true,
})

vim.filetype.add({
	extension = {
		dataviewjs = "javascript",
	},
})
