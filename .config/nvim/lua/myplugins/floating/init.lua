local M = {}

local todo_path = "/tmp/todo.md"
local draft_path = "/tmp/draft.md"

local default_opts = {
	width = 0.6,
	height = 0.8,
	border = "single",
}

local function win_config(opts)
	local width = math.min(math.floor(vim.o.columns * opts.width), 128)
	local height = math.floor(vim.o.lines * opts.height)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	return {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		border = opts.border,
	}
end

local function get_week_range(offset)
	local now = os.time() + offset * 7 * 24 * 60 * 60
	local day_of_week = tonumber(os.date("%w", now)) -- Sunday=0, Monday=1 ... Saturday=6

	-- Shift so Monday=0
	if day_of_week == 0 then
		day_of_week = 6
	else
		day_of_week = day_of_week - 1
	end

	-- Start of week (Monday)
	local week_start = os.date("*t", now - day_of_week * 24 * 60 * 60)
	-- End of week (Sunday)
	local week_end = os.date("*t", now + (6 - day_of_week) * 24 * 60 * 60)

	local start_str = string.format("%04d-%02d-%02d", week_start.year, week_start.month, week_start.day)
	local end_str = string.format("%04d-%02d-%02d", week_end.year, week_end.month, week_end.day)

	return "Week " .. start_str .. " -> " .. end_str
end

local function open_float(opts, file_path)
	local buf = vim.fn.bufnr(file_path, true)

	vim.bo[buf].swapfile = false

	local win_conf = win_config(opts)
	win_conf.title = file_path
	win_conf.title_pos = "center"

	vim.api.nvim_open_win(buf, true, win_conf)

	vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
		noremap = true,
		silent = true,
		callback = function()
			if vim.api.nvim_get_option_value("modified", { buf = buf }) then
				vim.notify("save your changes pls", vim.log.levels.WARN)
			else
				vim.api.nvim_win_close(0, true)
			end
		end,
	})

	return buf
end

local function setup_user_cmds(opts)
	vim.api.nvim_create_user_command("Todo", function()
		open_float(opts, todo_path)
	end, {})
	vim.api.nvim_create_user_command("Draft", function()
		open_float(opts, draft_path)
	end, {})
	vim.api.nvim_create_user_command("Planner", function(cmd_opts)
		local opt = cmd_opts.args ~= "" and cmd_opts.args or ""

		local offset = 0

		if opt == "" or opt == "current" then
			offset = 0
		elseif opt == "next" then
			offset = 1
		elseif opt == "prev" then
			offset = -1
		end

		print(offset)

		open_float(opts, "/home/leminhohoho/note-taking/Monadikos/planners/" .. get_week_range(offset) .. ".md")
	end, {
		nargs = "?",
		complete = function(arg_lead)
			local suggestions = {
				"current",
				"next",
				"prev",
			}

			local filtered = {}
			for _, suggestion in ipairs(suggestions) do
				if suggestion:lower():find(arg_lead:lower(), 1, true) then
					table.insert(filtered, suggestion)
				end
			end

			return filtered
		end,
	})

	vim.api.nvim_create_user_command("Snippet", function(cmd_opts)
		local name = vim.fn.input("Enter snippet name:")
		local today = os.date("%Y-%m-%d")

		open_float(
			opts,
			"/home/leminhohoho/note-taking/Monadikos/0 knowledge/1 snippets/" .. today .. "_" .. name .. ".md"
		)
	end, {})
end

M.setup = function(opts)
	opts = vim.tbl_deep_extend("force", default_opts, opts)

	setup_user_cmds(opts)
end

return M
