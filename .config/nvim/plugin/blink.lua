vim.pack.add({
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/micangl/cmp-vimtex",
	"https://github.com/saghen/blink.compat",
	"https://github.com/saghen/blink.cmp",
})

require("blink.cmp").setup({
	keymap = {
		["<Tab>"] = { "accept", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = true },
		menu = {
			draw = {
				columns = { { "item_idx" }, { "kind_icon" }, { "label", "label_description", gap = 1 } },
				components = {
					item_idx = {
						text = function(ctx)
							return ctx.idx == 10 and "0" or ctx.idx >= 10 and " " or tostring(ctx.idx)
						end,
						highlight = "BlinkCmpItemIdx", -- optional, only if you want to change its color
					},
				},
			},
		},
	},
	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer", "vimtex" },
		per_filetype = {
			sql = { "snippets", "dadbod", "buffer" },
		},
		providers = {
			dadbod = {
				name = "Dadbod",
				module = "vim_dadbod_completion.blink",
			},
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				-- make lazydev completions top priority (see `:h blink.cmp`)
				score_offset = 100,
			},
			vimtex = {
				name = "vimtex",
				min_keyword_length = 2,
				module = "blink.compat.source",
				score_offset = 80,
			},
		},
	},
	fuzzy = { implementation = "lua" },
})
