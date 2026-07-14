vim.pack.add({ "https://github.com/RRethy/vim-illuminate" })

require("illuminate").configure({
	providers = { "regex" },
	delay = 20,
	under_cursor = true,
	large_file_cutoff = nil,
	min_count_to_highlight = 2,
	should_enable = function(_)
		return true
	end,
	case_insensitive_regex = false,
})
