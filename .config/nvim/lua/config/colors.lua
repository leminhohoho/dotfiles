-- Function apply colors to specific filetype
local assign = function(pattern, callback)
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = pattern,
		callback = callback,
	})
end

-- Modify color scheme for transparency mode
vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight NormalNC guibg=none
  highlight VertSplit guibg=none
  highlight SignColumn guibg=none
  highlight WinSeparator guibg=none guifg=#353535
  highlight TelescopeNormal guibg=none
]])

-- Telescope borders --
vim.cmd("highlight TelescopeBorder guifg=#F9F6EE")

-- Code color adjustment --
vim.cmd("highlight Function gui=bold")
vim.cmd("highlight Comment guifg=#636a74 gui=italic")
vim.cmd("highlight @type gui=italic")
vim.cmd("highlight @string.escape guifg=#CEFE86")
vim.cmd("highlight ParenBlue guifg=#79c0ff")
vim.cmd("highlight ParenYellow guifg=#e2b340")
vim.cmd("highlight ParenGreen guifg=#54d062")
vim.cmd("highlight ParenLightPink guifg=#fda097")
vim.cmd("highlight ParenPink guifg=#ff9bce")
vim.cmd("highlight ParenPurple guifg=#ff9bce")

-- Status line color adjustment --
vim.cmd("highlight statusline guifg=white guibg=NONE gui=NONE")
vim.cmd("highlight statuslineNC guifg=black guibg=NONE gui=NONE")

-- Notification color adjustment --
vim.cmd("highlight NotificationInfo guifg=#7CFC00 guibg=NONE")

-- Modify zen bg color --
vim.cmd("highlight ZenBg guibg=none")

-- Markdown color options --
assign("*.md", function()
	vim.cmd("highlight @markup.heading.1.markdown guibg=#00FFFFFF guifg=#d29922 gui=bold")
	vim.cmd("highlight @markup.heading.2.markdown guibg=#00FFFFFF guifg=#3fb950 gui=bold")
	vim.cmd("highlight @markup.heading.3.markdown guibg=#00FFFFFF guifg=#ab8ad1 gui=bold")
	vim.cmd("highlight Normal guibg=#00FFFFFF guifg=#EDEADE")
	vim.cmd("highlight NormalNC guibg=#00FFFFFF guifg=#EDEADE")
	vim.cmd("highlight @markup.quote.markdown guibg=#00FFFFFF guifg=#FFF8DC gui=italic")
	vim.cmd("highlight RenderMarkdownCodeInline guibg=#1d2a37 guifg=#ef3745 gui=bold")
	vim.cmd("highlight @markup.link.label guifg=#4169E1 gui=bold")
	vim.cmd("highlight RenderMarkdownCode guibg=#1d2a39")
end)

-- Modify NOTE todo comment --
vim.cmd("highlight TodoBgNOTE guifg=#000000 guibg=#54d062 gui=bold")
vim.cmd("highlight TodoFgNOTE guifg=#54d062")
