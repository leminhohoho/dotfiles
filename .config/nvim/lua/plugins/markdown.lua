return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	-- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
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
					web = { pattern = "^http[s]?://", icon = "󰌹 ", highlight = "@markup.link.label" },
					youtube = { pattern = "^https://www.youtube.com", icon = "󰗃 ", highlight = "ErrorMsg" },
					github = { pattern = "https://github.com", icon = " ", highlight = "@none" },
					reddit = { pattern = "https://www.reddit.com", icon = " ", highlight = "@constructor" },
				},
			},
			checkbox = {
				custom = {
					todo = { raw = "[~]", rendered = "󰀃 ", highlight = "@constructor", scope_highlight = nil },
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
				note = { raw = "[!NOTE]", rendered = "✎ Note", highlight = "@function.macro" },
				important = { raw = "[!IMPORTANT]", rendered = " Important", highlight = "@constant.macro" },
				dictionary = { raw = "[!DICT]", rendered = "󱓷 Dictionary", highlight = "@module.php" },
			},
		})
	end,
}
