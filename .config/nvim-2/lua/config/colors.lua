local function change_bg(color)
	os.execute([[echo "background-opacity = 1" >> ~/.config/ghostty/.config | pkill -USR2 ghostty]])
	os.execute(string.format([[echo "background = %s" >> ~/.config/ghostty/.config | pkill -USR2 ghostty]], color))
end

local function get_hl(hl_name)
	local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
	return {
		fg = string.format("#%06x", hl.fg),
		bg = string.format("#%06x", hl.bg),
	}
end

-- Set the default highlight groups across colorschemes
local function default()
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinBar", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinBarNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinSeparator", { bg = "none", fg = "#3c3836" })
	vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
end

-- Listen on file changes to trigger update across neovim instances
vim.uv.new_fs_event():start("/tmp/colorscheme", {}, function(err, filename, status)
	vim.schedule(function()
		if err then
			print("Error watching file:", err)
			return
		end

		local file = io.open("/tmp/colorscheme")

		if file then
			local content = string.format("%s", file:read("*a"))
			file:close()

			vim.cmd([[colorscheme ]] .. content)
		end
	end)
end)

-- Auto command for applying modifications to colorscheme when changing
vim.api.nvim_create_autocmd({ "Colorscheme" }, {
	callback = function()
		default()

		local bg = get_hl("Normal").bg
		local md_tools = require("myplugins.markdown_tools")

		local colorscheme = string.format("%s", vim.g.colors_name)

		local file = io.open("/tmp/colorscheme")

		if file then
			local content = string.format("%s", file:read("*a"))
			file:close()

			if not content:find(colorscheme, 1, true) and not colorscheme:find(content, 1, true) then
				vim.cmd(string.format([[silent !echo %s > /tmp/colorscheme]], colorscheme))
				change_bg(bg)
			end
		end

		if colorscheme == "gruvbox-material" then
			-- Telescope
			vim.api.nvim_set_hl(0, "TelescopeNormal", { link = "Folded" })
			vim.api.nvim_set_hl(0, "TelescopeBorder", { link = "Folded" })
			vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { link = "Folded" })
			vim.api.nvim_set_hl(0, "TelescopePromptTitle", { link = "TSNote" })
			vim.api.nvim_set_hl(0, "TelescopePromptBorder", { link = "Visual" })
			vim.api.nvim_set_hl(0, "TelescopePromptNormal", { link = "Visual" })
			vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { link = "TSDanger" })
			vim.api.nvim_set_hl(0, "TelescopeSelection", { link = "Visual" })
			vim.api.nvim_set_hl(0, "TelescopePromptCounter", { link = "Fg" })

			-- Noice.nvim
			vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { fg = "#7daea3", bold = true })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", { link = "NormalFloat" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#45403d", bg = "#45403d" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = "#45403d", bg = "#45403d" })
			vim.api.nvim_set_hl(0, "NoiceCmdlinePopupTitleInput", { link = "Blue" })

			-- Snacks.nvim
			vim.api.nvim_set_hl(0, "SnacksInputNormal", { link = "NormalFloat" })
			vim.api.nvim_set_hl(0, "SnacksInputBorder", { link = "NormalFloat" })
			vim.api.nvim_set_hl(0, "SnacksImageMath", { link = "Normal" })

			-- Molten.nvim
			vim.api.nvim_set_hl(0, "MoltenOutputBorderSuccess", { fg = "#a9b665", bg = "#45403d", bold = true })
			vim.api.nvim_set_hl(0, "MoltenOutputBorderFail", { fg = "#ea6962", bg = "#45403d", bold = true })
			vim.api.nvim_set_hl(0, "MoltenOutputWin", { bg = "#45403d" })

			-- Markdown
			vim.api.nvim_set_hl(0, "@markup.link.label", { link = "Blue" })
			vim.api.nvim_set_hl(0, "YellowItalic", { link = "Blue" })
			vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#3c3836" })
			vim.api.nvim_set_hl(0, "Strikethrough", { fg = "#928374", strikethrough = true })
			vim.api.nvim_set_hl(0, "Doing", { fg = "#d8a657", italic = true })
			vim.api.nvim_set_hl(0, "Failed", { fg = "#ea6962", bold = true })
			vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = "#d4be98" })
			vim.api.nvim_set_hl(0, "@markup.quote.markdown", { link = "Fg" })

			-- Markdown links
			vim.api.nvim_set_hl(0, "MarkdownLink", { fg = "#458588", underline = true })
			md_tools.add_link_hl("MarkdownLink", "")
			vim.api.nvim_set_hl(0, "YoutubeLink", { fg = "#fb4934", underline = true })
			md_tools.add_link_hl("YoutubeLink", [[www\.youtube\.com]])
			md_tools.add_link_hl("YoutubeLink", [[youtu\.be]])
			vim.api.nvim_set_hl(0, "GithubLink", { fg = "#d3869b", underline = true })
			md_tools.add_link_hl("GithubLink", [[github\.com]])
			vim.api.nvim_set_hl(0, "RedditLink", { fg = "#e7834e", underline = true })
			md_tools.add_link_hl("RedditLink", [[www\.reddit\.com]])
			vim.api.nvim_set_hl(0, "ColabLink", { fg = "#d8a657", underline = true })
			md_tools.add_link_hl("ColabLink", [[colab\.research\.google.com]])
			vim.api.nvim_set_hl(0, "TorchDocLink", { fg = "#d65d0e", underline = true })
			md_tools.add_link_hl("TorchDocLink", [[docs\.pytorch\.org]])
			vim.api.nvim_set_hl(0, "NumpyLink", { fg = "#83a598", underline = true })
			md_tools.add_link_hl("NumpyLink", [[numpy\.org]])

			-- Blink.cmp
			vim.api.nvim_set_hl(0, "BlinkCmpGhostText", { fg = "#7C6F64" })

			if not vim.g.neovide then
				vim.cmd(":hi Normal guibg=none ctermbg=none")
			end

			os.execute([[echo "background-opacity = 0.9" >> ~/.config/ghostty/.config | pkill -USR2 ghostty]])
		end
	end,
})

-- Set default colorscheme
vim.cmd("colorscheme gruvbox-material")
