-------------------- CODING COMMANDS --------------------

-------------------- NOTE TAKING COMMANDS --------------------
vim.api.nvim_create_autocmd("FileType", {

	pattern = "markdown",
	callback = function()
		-- Picker for choosing french character
		vim.api.nvim_create_user_command("FrenchChar", function()
			vim.ui.select({
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
			}, { prompt = "Choose a character" }, function(choice)
				if choice then
					vim.cmd("normal! a" .. choice)
				else
					print("Selection cancelled")
				end
			end)
		end, {})

		-- note-taking system (zettlekasten) keymaps
		vim.keymap.set("n", "<leader>fb", require("myplugins.markdown_tools").backlink)
		vim.keymap.set("n", "<leader>fr", require("myplugins.markdown_tools").find_resources)

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
					"Warn",
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
