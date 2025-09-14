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
						icon = "",
					},
					custom = {
						excalidraw = { pattern = "%.excalidraw$", icon = " ", highlight = "@float" },
						web = { pattern = "^http[s]?://", icon = "󰌹 ", highlight = "Identifier" },
						youtube = { pattern = "^https://www.youtube.com", icon = "󰗃 ", highlight = "Error" },
						github = { pattern = "https://github.com", icon = " ", highlight = "Constant" },
						reddit = { pattern = "https://www.reddit.com", icon = " ", highlight = "Debug" },
					},
				},
				checkbox = {
					-- enabled = false,
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
					dictionary = { raw = "[!DICT]", rendered = "󱓷 Dictionary", highlight = "Define" },
					example = { raw = "[!EXAMPLE]", rendered = " Example", highlight = "Comment" },
				},
			}

			md.setup(opts)

			-- -- Avante buffer customization
			-- vim.api.nvim_create_autocmd({ "FileType" }, {
			-- 	pattern = "codecompanion",
			-- 	callback = function()
			-- 		local extended_opts = vim.tbl_extend("force", opts, {
			-- 			heading = { enabled = true, position = "inline", backgrounds = {} },
			-- 		})
			--
			-- 		md.setup(extended_opts)
			-- 	end,
			-- })
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
