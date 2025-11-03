return {
	"obsidian-nvim/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local obsidian = require("obsidian")

		obsidian.setup({
			templates = {
				folder = "templates",
			},
			workspaces = {
				{
					name = "linux",
					path = "~/note-taking/Elastikos",
					overrides = {
						daily_notes = {
							folder = "daily notes",
						},
					},
				},
				{
					name = "note",
					path = "~/note-taking/Monadikos",
					overrides = {
						daily_notes = {
							folder = "daily notes",
							date_format = "%Y.%m.%d",
						},
					},
				},
			},
			completion = {
				blink = true,
			},
			ui = { enable = false },
			follow_url_func = function(url)
				-- Open the URL in the default web browser.
				-- vim.fn.jobstart({ "open", url }) -- Mac OS
				vim.fn.jobstart({ "xdg-open", url }) -- linux
				-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
				-- vim.ui.open(url) -- need Neovim 0.10.0+
			end,
			open = {
				func = function()
					local file = vim.api.nvim_buf_get_name(0)
					local dir = vim.fn.fnamemodify(file, ":h")

					print("hi")
				end,
			},
			callbacks = {
				enter_note = function(_, note)
					local util = require("obsidian.api")

					-- WARNING: Current only support absolute paths
					vim.keymap.set("n", "<leader>eo", function()
						local link = util.cursor_link()
						if link == nil then
							print("link is nil")
							return
						end

						local diagram_path = link:match("%b()")
						diagram_path = diagram_path:sub(2, -2)

						print("gtk-launch brave-dnfpoenibinnbbckgbhendmlljoobcfg-Default.desktop " .. diagram_path)
						vim.cmd("! gtk-launch brave-dnfpoenibinnbbckgbhendmlljoobcfg-Default.desktop " .. diagram_path)
					end, { buffer = note.bufnr })

					vim.keymap.set("n", "<leader>en", function()
						local name = vim.fn.input("Name of the diagram")
						local diagram_dir = "/home/leminhohoho/note-taking/Monadikos/.excalidraw"
						local diagram_path = diagram_dir .. "/" .. name .. ".excalidraw"

						-- local file = vim.api.nvim_buf_get_name(0)
						-- local dir = vim.fn.fnamemodify(file, ":h")

						vim.cmd("! touch " .. diagram_path)
						local markdown_link = "[" .. name .. "](" .. diagram_path .. ")"

						local lines = {
							"{",
							'  "type": "excalidraw",',
							'  "version": 2,',
							'  "source": "https://excalidraw.com",',
							'  "elements": [],',
							'  "appState": {',
							'    "gridSize": 20,',
							'    "gridStep": 5,',
							'    "gridModeEnabled": false,',
							'    "viewBackgroundColor": "#ffffff",',
							'    "lockedMultiSelections": {}',
							"  },",
							'  "files": {}',
							"}",
						}

						vim.fn.writefile(lines, diagram_path)

						vim.cmd("normal! i" .. markdown_link)

						print(diagram_path)

						vim.cmd("! gtk-launch brave-dnfpoenibinnbbckgbhendmlljoobcfg-Default.desktop " .. diagram_path)
					end, { buffer = note.bufnr })
				end,
			},
		})
	end,
}
