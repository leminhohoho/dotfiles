-- Modify colors for each colorscheme
vim.api.nvim_create_autocmd({ "Colorscheme" }, {
	callback = function()
		-- Modify color scheme for transparency mode
		if not vim.g.neovide then
			print("gotcha")
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
			vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
			vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
			vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
			vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none" })
			vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "#3c3836" })
			vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
		end

		-- Modify color for illuminate.nvim
		vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#504954", underline = false })

		-- Moddify color for notification
		vim.api.nvim_set_hl(0, "NotificationInfo", { bg = "none" })

		-- Modify diagnostic virtual text to match the sign color
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { link = "DiagnosticSignError" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarning", { link = "DiagnosticSignWarning" })

		local colorscheme = vim.g.colors_name

		if colorscheme == "gruvbox" then
			vim.cmd("highlight GruvboxRedSign guibg=none")
			vim.cmd("highlight GruvboxYellowSign guibg=none")
			vim.cmd("highlight GruvboxBlueSign guibg=none")

			-- Telescope borders
			vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "GruvboxBg3" })
			vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "GruvboxBg3" })
			vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "GruvboxBg3" })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "GruvboxBg3" })
		elseif colorscheme == "gruvbox-material" then
			-- Telescope borders
			vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "Comment" })
			vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { link = "Comment" })
			vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "Comment" })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Comment" })

			-- Noice cmdline
			vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { link = "Green" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopUpTitle", { link = "Green" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopUpBorder", { link = "Green" })

			-- Zen mode background
			vim.api.nvim_set_hl(0, "ZenBg", { bg = "none" })

			-- render-markdown
			vim.api.nvim_set_hl(0, "@markup.quote.markdown", { link = "Normal" })
			vim.api.nvim_set_hl(0, "Strikethrough", { fg = "#928374", strikethrough = true })
			vim.api.nvim_set_hl(0, "Doing", { fg = "#d8a657", italic = true })
			vim.api.nvim_set_hl(0, "Failed", { fg = "#ea6962", bold = true })
		end
	end,
})

-- Modify color for markdown files
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.md",
	callback = function()
		-- vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { bg = "none", fg = "#d29922", bold = true })
		-- vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { bg = "none", fg = "#3fb950", bold = true })
		-- vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { bg = "none", fg = "#ab8ad1", bold = true })
		vim.api.nvim_set_hl(0, "Normal", { fg = "#ebdbb2" })
		vim.api.nvim_set_hl(0, "NormalNC", { fg = "#ebdbb2" })
	end,
})
