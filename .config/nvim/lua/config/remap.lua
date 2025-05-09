vim.g.mapleader = " "

local bind = function(mode, key, command)
	vim.keymap.set(mode, key, command, { silent = true })
end

-------------------- DISABLE KEYMAPS --------------------
bind("n", "<up>", ':echo "Deez nuts"<CR>')
bind("n", "<down>", ':echo "Deez nuts"<CR>')
bind("n", "<left>", ':echo "Deez nuts"<CR>')
bind("n", "<right>", ':echo "Deez nuts"<CR>')

-------------------- WORKBENCH KEYMAPS --------------------
-- Split buffers
bind("n", "<leader>sv", ":vsplit<CR>")
bind("n", "<leader>sh", ":split<CR>")

-- Toggle netrw
bind("n", "<leader>e", function()
	local filetype = vim.bo.filetype

	if filetype == "netrw" then
		vim.cmd(":b#")
	else
		vim.cmd("Ex")
	end
end)

-- Auto session keymaps
bind("n", "<leader>wr", ":SessionRestore<CR>")
bind("n", "<leader>ws", ":SessionSave<CR>")

-- Telescope keymaps
bind("n", "<leader>ff", ":Telescope find_files<CR>")
bind("n", "<leader>fg", ":Telescope live_grep<CR>")
bind("n", "<leader>fb", ":Telescope buffers<CR>")
bind("n", "<leader>fh", ":Telescope help_tags<CR>")
bind("n", "<Leader>hh", ":Telescope highlights<CR>")
-- Open todo comments with telescope
bind("n", "<leader>td", function()
	require("telescope").extensions["todo-comments"].todo({
		layout_strategy = "vertical",
		layout_config = {
			width = 0.8,
			height = 0.8,
		},
	})
end, { noremap = true, silent = true })

-- Open Dbee
bind("n", "<leader>db", function()
	require("dbee").open()
end)

-- Oil.nvim keymaps
bind("n", "<leader>oo", ":Oil<CR>")

-- Lazygit keymaps
bind("n", "<leader>lg", ":LazyGit<CR>")

-- Namu.nvim keymaps
bind("n", "<leader>ss", ":Namu symbols<CR>")

-- Moving around in tree walker
bind("n", "<leader>j", ":Treewalker Down<CR>")
bind("n", "<leader>k", ":Treewalker Up<CR>")
bind("n", "<leader>h", ":Treewalker Left<CR>")
bind("n", "<leader>l", ":Treewalker Right<CR>")

-- Toggling cursor center
bind("n", "<leader>tc", ':lua require("stay-centered").toggle()<CR>')

-------------------- CODING KEYMAPS --------------------
-- Go to start & end of line
bind({ "n", "v" }, "fh", "^")
bind({ "n", "v" }, "fl", "$")

-- Copy to clipboard
bind("v", "<leader>y", '"+y')
bind("n", "<leader>yy", '"+yy')

-- Turn of search highlight
bind("n", "<leader>th", ":nohlsearch<CR>")

-------------------- NOTE TAKING KEYMAPS --------------------

-------------------- CUSTOM COMMANDS --------------------
-- Command to save using Confom.nvim specifically
vim.api.nvim_create_user_command("W", function(args)
	require("conform").format({ bufnr = args.buf })
	vim.cmd("write")
end, {
	nargs = 0,
})

-------------------- MISCELLANEOUS --------------------
