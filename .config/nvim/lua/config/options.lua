vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 0
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
vim.o.updatetime = 300
vim.o.swapfile = false
vim.o.wrap = true

------------------- NETRW CUSTOMIZATION -------------------
-- Keep netrw in 1 buffer instead of switching to different ones as entering directories
vim.cmd("let g:netrw_liststyle = 3")

-- Remove netrw banner
vim.g.netrw_banner = 0

-- Show directories first (sorting)
vim.g.netrw_sort_sequence = [[[\/]$,*]]

-- Disable dadbod nvim execute query on save
vim.g.db_ui_execute_on_save = 0

------------------- MISCELLANEOUS -------------------
-- Set line breaks to preserve words
vim.cmd("set linebreak")

-- Neovide configuration
if vim.g.neovide then
	vim.o.guifont = "JetBrainsMono Nerd Font Mono:h8"
	vim.g.neovide_scale_factor = 1.0
end
