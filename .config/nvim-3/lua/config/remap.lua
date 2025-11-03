vim.g.mapleader = " "

local silent_bind = function(mode, key, command)
	vim.keymap.set(mode, key, command, { silent = true })
end

-------------------- DISABLE KEYMAPS --------------------
silent_bind("n", "<up>", ':echo "Deez nuts"<CR>')
silent_bind("n", "<down>", ':echo "Deez nuts"<CR>')
silent_bind("n", "<left>", ':echo "Deez nuts"<CR>')
silent_bind("n", "<right>", ':echo "Deez nuts"<CR>')

-------------------- WORKBENCH KEYMAPS --------------------
-- Split buffers
silent_bind("n", "<leader>sv", ":vsplit<CR>")
silent_bind("n", "<leader>sh", ":split<CR>")

-- Toggle netrw
silent_bind("n", "<leader>e", function()
	local filetype = vim.bo.filetype

	if filetype == "netrw" then
		vim.cmd(":b#")
	else
		vim.cmd("Ex")
	end
end)

-- Auto session keymaps
silent_bind("n", "<leader>wr", ":SessionRestore<CR>")
silent_bind("n", "<leader>ws", ":SessionSave<CR>")

-- Telescope keymaps
silent_bind("n", "<leader>ff", ":Telescope find_files<CR>")
silent_bind("n", "<leader>fg", ":Telescope live_grep<CR>")
silent_bind("n", "<leader>fb", ":Telescope buffers<CR>")
silent_bind("n", "<leader>fh", ":Telescope help_tags<CR>")
silent_bind("n", "<Leader>hh", ":Telescope highlights<CR>")

-- Open todo comments with telescope
silent_bind("n", "<leader>td", function()
	require("telescope").extensions["todo-comments"].todo({
		layout_strategy = "vertical",
		layout_config = {
			width = 0.8,
			height = 0.8,
		},
		borderchars = {
			prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
			preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		},
	})
end)

-- Trouble keymaps
silent_bind("n", "<leader>xx", ":Trouble diagnostics toggle<CR>")

-- Oil.nvim keymaps
silent_bind("n", "<leader>o", ":Oil<CR>")

-- Lazygit keymaps
silent_bind("n", "<leader>lg", ":LazyGit<CR>")

-- Namu.nvim keymaps
silent_bind("n", "<leader>ss", ":Namu symbols<CR>")

-- Remove openning pop ups
silent_bind("n", "<leader><leader>", "<cmd>NoiceDismiss<CR>")

-- open float todo
silent_bind("n", "<leader>do", ":Todo<CR>")

-- open float draft
silent_bind("n", "<leader>dr", ":Draft<CR>")

-- open planner for current week
silent_bind("n", "<leader>pc", ":Planner current<CR>")
silent_bind("n", "<leader>pn", ":Planner next<CR>")
silent_bind("n", "<leader>pv", ":Planner prev<CR>")

-- create/open a snippet note
silent_bind("n", "<leader>ns", ":Snippet<CR>")

-- create/open a resource note
silent_bind("n", "<leader>nr", ":ResourceNew<CR>")

-- create/open a fleeting note
silent_bind("n", "<leader>nf", ":FleetingNew<CR>")

-------------------- CODING KEYMAPS --------------------
-- Go to start & end of line
silent_bind({ "n", "v" }, "fh", "^")
silent_bind({ "n", "v" }, "fl", "$")

-- Copy to clipboard
silent_bind("v", "<leader>y", '"+y')
silent_bind("n", "<leader>yy", '"+yy')

-- Turn of search highlight
silent_bind("n", "<leader>th", ":nohlsearch<CR>")

-- Moving around in tree walker
silent_bind("n", "<leader>j", ":Treewalker Down<CR>")
silent_bind("n", "<leader>k", ":Treewalker Up<CR>")
silent_bind("n", "<leader>h", ":Treewalker Left<CR>")
silent_bind("n", "<leader>l", ":Treewalker Right<CR>")

-------------------- NOTE TAKING KEYMAPS --------------------
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
	pattern = "markdown",
	callback = function()
		-- Open TOC
		silent_bind("n", "<leader>toc", ":ObsidianTOC<CR>")
		-- Search obsidian tags
		silent_bind("n", "<leader>st", ":ObsidianTags<CR>")
		-- Rename file (update across backlinks)
		silent_bind("n", "<leader>rn", ":ObsidianRename<CR>")
		-- Search resources notes
		silent_bind("n", "<leader>fr", ":ResourcesList<CR>")
		-- Open french character pallete
		silent_bind("n", "fc", ":FrenchChar<CR>")

		-- Command for inserting code block
		vim.api.nvim_create_user_command("Block", function(opts)
			local language = opts.args ~= "" and opts.args or ""

			vim.api.nvim_put({ "```" .. language, "", "```" }, "c", true, true)
			vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1] - 1, 0 })
		end, { nargs = "?" })

		-- Command for inserting callout block
		vim.api.nvim_create_user_command("CO", function(opts)
			local callout_name = opts.args ~= "" and opts.args or ""

			vim.api.nvim_put({ "> [!" .. string.upper(callout_name) .. "]", "> " }, "c", true, true)
		end, {
			nargs = "?",
			complete = function(arg_lead)
				local suggestions = {
					"Note",
					"Important",
					"Dict",
					"Example",
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
	end,
})
-------------------- CUSTOM COMMANDS --------------------
-- Command to save using Confom.nvim specifically
vim.api.nvim_create_user_command("W", function(args)
	require("conform").format({ bufnr = args.buf })
	vim.cmd("write")
end, {
	nargs = 0,
})

-- Activate otter.nvim for LSP in markdown code blocks
vim.api.nvim_create_user_command("Otter", function()
	require("otter").activate()
end, {})

-------------------- MISCELLANEOUS --------------------
-- find project resources
vim.api.nvim_create_user_command("ResourcesList", function()
	vim.cmd("ObsidianBacklinks")

	vim.defer_fn(function()
		vim.api.nvim_feedkeys("resources", "i", true)
	end, 200)
end, {})

-- Choose french language
vim.api.nvim_create_user_command("FrenchChar", function()
	vim.ui.select(
		{
			"ù",
			"û",
			"ü",
			"ÿ",
			"€",
			"à",
			"â",
			"æ",
			"ç",
			"é",
			"è",
			"ê",
			"ë",
			"ï",
			"î",
			"ô",
			"œ",
		}, -- items to select from
		{ prompt = "Choose an character:" }, -- optional opts
		function(choice) -- callback
			if choice then
				vim.cmd("normal! a" .. choice)
			else
				print("Selection cancelled")
			end
		end
	)
end, {})
