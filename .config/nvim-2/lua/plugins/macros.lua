return {
	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"mg979/vim-visual-multi",
		config = function() end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			highlight = {
				backdrop = true,
				-- Highlight the search matches
				matches = true,
				-- extmark priority
				priority = 5000,
				groups = {
					match = "@diff.plus",
					current = "FlashCurrent",
					backdrop = "FlashBackdrop",
					label = "RedrawDebugRecompose",
				},
			},
		},
  -- stylua: ignore
    keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
	},
	"aaronik/treewalker.nvim",
	opts = {
		highlight = true, -- default is false
	},
}
