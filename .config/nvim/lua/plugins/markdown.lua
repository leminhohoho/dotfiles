return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion", "ipynb" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		config = function()
			local md = require("render-markdown")

			local opts = {
				enabled = true,
				render_modes = { "n", "c", "t", "i", "V", "v" },
				indent = {
					enabled = false,
					per_level = 2,
				},
				link = {
					wiki = {
						icon = " ",
					},
					custom = {
						web = { pattern = "^http[s]?://", icon = "󰖟 ", highlight = "Blue" },
						youtube = { pattern = "^https://www.youtube.com", icon = "󰗃 ", highlight = "YoutubeLink" },
						github = { pattern = "https://github.com", icon = " ", highlight = "GithubLink" },
						reddit = { pattern = "https://www.reddit.com", icon = " ", highlight = "RedditLink" },
						google_colab = {
							pattern = "https://colab.research.google.com",
							icon = " ",
							highlight = "ColabLink",
						},
						pytorch_doc = {
							pattern = "https://docs.pytorch.org",
							icon = " ",
							highlight = "TorchDocLink",
						},
						numpy_doc = {
							pattern = "https://numpy.org",
							icon = " ",
							highlight = "NumpyLink",
						},
					},
				},
				checkbox = {
					checked = {
						highlight = "RenderMarkdownChecked",
						scope_highlight = "Strikethrough",
					},
					custom = {
						doing = { raw = "[~]", rendered = "󰀃 ", highlight = "Special", scope_highlight = "Doing" },
						fail = {
							raw = "[!]",
							rendered = " ",
							highlight = "Error",
							scope_highlight = "Failed",
						},
					},
				},
				quote = { repeat_linebreak = true },
				win_options = {
					showbreak = {
						default = "",
						rendered = "  ",
					},
					breakindent = {
						default = false,
						rendered = true,
					},
					breakindentopt = {
						default = "",
						rendered = "",
					},
				},
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
					left_pad = 2,
					border = "thick",
				},
				callout = {
					note = { raw = "[!NOTE]", rendered = "✎ Note", highlight = "Changed" },
					important = { raw = "[!IMPORTANT]", rendered = " Important", highlight = "Constant" },
					warn = { raw = "[!WARN]", rendered = " Warning", highlight = "WarningMsg" },
					dictionary = { raw = "[!DICT]", rendered = "󱓷 Dictionary", highlight = "Define" },
					example = { raw = "[!EXAMPLE]", rendered = " Example", highlight = "Comment" },
				},
			}

			md.setup(opts)
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
