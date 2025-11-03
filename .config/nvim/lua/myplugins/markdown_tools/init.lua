local M = {}

local function highlight_md_links(hl, domain)
	local labelled_link_pattern = string.format([[\v\zs\[.{-}\ze\]\((https?:\/\/)?(%s)\/[^)]*\)]], domain)
	local wiki_link_pattern = string.format("\\[\\[\\(https:\\/\\/%s.*\\)\\]\\]", domain)
	local normal_link_pattern = string.format("\\[\\(https:\\/\\/%s.*\\)\\]", domain)

	vim.fn.matchadd(hl, labelled_link_pattern)
	vim.fn.matchadd(hl, wiki_link_pattern)
	vim.fn.matchadd(hl, normal_link_pattern)
end

-- Add highlight to markdown links based on domains
M.add_link_hl = function(hl, domain)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function()
			highlight_md_links(hl, domain)
		end,
	})
end

-- Find backlinks to the current note
M.backlink = function()
	local builtin = require("telescope.builtin")
	local filename = vim.fn.expand("%:t:r")
	if filename == "" then
		vim.notify("No filename detected", vim.log.levels.WARN)
		return
	end

	local pattern = string.format("[[%s]]", filename)

	builtin.grep_string({
		search = pattern,
		prompt_title = "Find Backlinks",
		preview_title = "Preview",
		additional_args = { "--glob", "*.md" },
	})
end

-- Find resources to the current project
M.find_resources = function()
	local builtin = require("telescope.builtin")
	local filename = vim.fn.expand("%:t:r")
	if filename == "" then
		vim.notify("No filename detected", vim.log.levels.WARN)
		return
	end

	local pattern = string.format("[[%s]]", filename)

	builtin.grep_string({
		search = pattern,
		prompt_title = "Find Resources",
		preview_title = "Preview",
		additional_args = { "--glob", "*resources.md" },
	})
end

-- Toggle todo list between modes
M.toggle_todo = function()
	local row = vim.fn.line(".") -- current line number
	local line = vim.fn.getline(row) -- get current line content

	if not string.match(line, "%- %[[x!~ ]%]") then
		return false
	end

	local new_line, count = string.gsub(line, "%- %[ %]", "- [~]", 1)
	if count == 0 then
		new_line, count = string.gsub(line, "%- %[~%]", "- [!]", 1)
		if count == 0 then
			new_line, count = string.gsub(line, "%- %[!%]", "- [x]", 1)
			if count == 0 then
				new_line = string.gsub(line, "%- %[x%]", "- [ ]", 1)
			end
		end
	end

	if new_line ~= line then
		vim.fn.setline(row, new_line)
	end

	return true
end

M.send_code = function()
	require("various-textobjs").mdFencedCodeBlock("inner")
	require("iron.core").mark_visual()
	require("iron.core").send_mark()
end

M.next_codeblock = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local lang_tree = vim.treesitter.get_parser(bufnr, "markdown")
	if not lang_tree then
		return
	end

	local root = lang_tree:parse()[1]:root()
	local current_row, _ = unpack(vim.api.nvim_win_get_cursor(0))

	local query = vim.treesitter.query.parse(
		"markdown",
		[[
    (fenced_code_block) @block
  ]]
	)

	local next_block_start_row = nil

	for _, node in query:iter_captures(root, bufnr, 0, -1) do
		local start_row, _, _, _ = node:range()
		if start_row > current_row - 1 then
			next_block_start_row = start_row
			break
		end
	end

	if next_block_start_row then
		vim.api.nvim_win_set_cursor(0, { next_block_start_row + 1, 0 })
	end
end

M.setup = function()
	-- Auto command to add frontmatter on save if not exist
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*.md",
		callback = function()
			local filename = vim.fn.expand("%:t:r")
			if filename == "README" then
				return
			end

			local filepath = vim.fn.expand("%:p")
			local file = io.open(filepath)
			if not file then
				return
			end

			local content = string.format("%s", file:read("*a"))
			if string.match(content, "^%-%-%-\n(.-)\n%-%-%-") then
				return
			end

			vim.api.nvim_buf_set_lines(0, 0, 0, false, {
				"---",
				string.format("id: %s", filename),
				"aliases: []",
				"tags: []",
				"---",
			})

			vim.cmd("w")
		end,
	})

	-- Smart key (Enter) implementation
	vim.keymap.set("n", "<CR>", function()
		if not M.toggle_todo() then
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
		end
	end, { silent = true })
end

return M
