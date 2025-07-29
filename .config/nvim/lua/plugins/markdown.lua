return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		config = function()
			local md = require("render-markdown")

			md.setup({
				enabled = true,
				indent = {
					enabled = false,
					per_level = 2,
				},
				link = {
					wiki = {
						icon = "",
					},
					custom = {
						web = { pattern = "^http[s]?://", icon = "󰌹 ", highlight = "Identifier" },
						youtube = { pattern = "^https://www.youtube.com", icon = "󰗃 ", highlight = "Error" },
						github = { pattern = "https://github.com", icon = " ", highlight = "Constant" },
						reddit = { pattern = "https://www.reddit.com", icon = " ", highlight = "Debug" },
					},
				},
				checkbox = {
					-- enabled = false,
					custom = {
						todo = { raw = "[~]", rendered = "󰀃 ", highlight = "Number", scope_highlight = nil },
						change = { raw = "[!]", rendered = " ", highlight = "Constant", scope_highlight = nil },
					},
				},
				quote = { repeat_linebreak = true },
				heading = {
					enabled = false,
				},
				bullet = {
					enabled = true,
					icons = { "•", "◦" },
					ordered_icons = {},
					left_pad = 0,
					right_pad = 0,
					highlight = "RenderMarkdownBullet",
				},
				code = {
					width = "block",
					left_pad = 2,
					right_pad = 4,
				},
				callout = {
					note = { raw = "[!NOTE]", rendered = "✎ Note", highlight = "Changed" },
					important = { raw = "[!IMPORTANT]", rendered = " Important", highlight = "Constant" },
					dictionary = { raw = "[!DICT]", rendered = "󱓷 Dictionary", highlight = "Define" },
					example = { raw = "[!EXAMPLE]", rendered = " Example", highlight = "Comment" },
				},
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
}
