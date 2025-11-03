local M = {}

local center_texts = function(width, height, lines)
	local centered_lines = {}

	local vertical_padding = math.max(0, math.floor((height - #lines) / 2))

	for _ = 1, vertical_padding, 1 do
		table.insert(centered_lines, "")
	end

	for _, line in ipairs(lines) do
		local clean_line = line:gsub("%s+$", "")

		local line_length = vim.fn.strdisplaywidth(clean_line)

		-- Calculate the padding (the space between the centered line and the edges (horizontally)
		local horizontal_padding = math.max(0, math.floor((width - line_length) / 2))

		local centered_line = string.rep(" ", horizontal_padding) .. clean_line

		table.insert(centered_lines, centered_line)
	end

	return centered_lines
end

M.setup = function(opts)
	if vim.fn.argc() ~= 0 then
		return
	end

	-- Create a new scratch buffer
	local buf = vim.api.nvim_create_buf(false, true)

	local width = vim.api.nvim_win_get_width(0)
	local height = vim.api.nvim_win_get_height(0)

	-- Define the content to display
	local lines = {
		"=================================",
		"WELCOME TO YOUR NEOVIM!",
		"=================================",
	}

	-- Set buffer options
	vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
	vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = buf })
	vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
	vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })

	-- Set the current window to display the new buffer
	vim.api.nvim_set_current_buf(buf)

	vim.opt_local.number = false
	vim.opt_local.relativenumber = false

	local timer = vim.loop.new_timer()
	local i = 100
	timer:start(
		0,
		20,
		vim.schedule_wrap(function()
			if not vim.api.nvim_buf_is_valid(buf) then
				return
			end

			if i < 0 then
				timer:stop()
				timer:close()

				vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
				vim.api.nvim_buf_set_lines(buf, 0, -1, false, center_texts(width, height, lines))
				vim.api.nvim_set_option_value("modifiable", false, { buf = buf })

				return
			end

			vim.api.nvim_set_option_value("modifiable", true, { buf = buf })
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, center_texts(width + i + 1, height, lines))
			vim.api.nvim_set_option_value("modifiable", false, { buf = buf })
			i = i - 1
		end)
	)
end

return M
