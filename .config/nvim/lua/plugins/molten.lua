return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 100
			vim.g.molten_tick_rate = 1000
			vim.g.molten_use_border_highlights = true
			vim.g.molten_virt_lines_off_by_1 = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_text_max_lines = 30
		end,
	},
	{
		-- see the image.nvim readme for more information about configuring this plugin
		"3rd/image.nvim",
		opts = {
			backend = "kitty", -- whatever backend you would like to use
			max_width = 100,
			max_height = 23,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
			integrations = {
				markdown = {
					enabled = false,
				},
			},
		},
	},
}
