return {
	"olimorris/codecompanion.nvim",
	opts = {},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"franco-ruggeri/codecompanion-spinner.nvim",
		"ravitemer/codecompanion-history.nvim",
	},
	config = function()
		local conf = {
			strategies = {
				chat = {
					adapter = "gpt5",
				},
				inline = {
					adapter = "openai",
				},
			},
			display = {
				chat = {
					window = {
						position = "right",
						width = 0.4,
					},
				},
			},
			adapters = {
				["gpt5-nano"] = function()
					return require("codecompanion.adapters").extend("openai", {
						name = "gpt5",
						opts = {
							search_web = true,
						},
						schema = {
							model = {
								default = "gpt-5-nano-2025-08-07",
							},
						},
					})
				end,
				gpt5 = function()
					return require("codecompanion.adapters").extend("openai", {
						name = "gpt5",
						opts = {
							search_web = true,
						},
						schema = {
							model = {
								default = "gpt-5-chat-latest",
							},
						},
					})
				end,
			},
			extensions = {
				spinner = {},
				history = {
					enabled = true,
					opts = {
						-- Keymap to open history from chat buffer (default: gh)
						keymap = "gh",
						-- Keymap to save the current chat manually (when auto_save is disabled)
						save_chat_keymap = "sc",
						-- Save all chats by default (disable to save only manually using 'sc')
						auto_save = true,
						-- Number of days after which chats are automatically deleted (0 to disable)
						expiration_days = 0,
						-- Picker interface (auto resolved to a valid picker)
						picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
						---Optional filter function to control which chats are shown when browsing
						chat_filter = nil, -- function(chat_data) return boolean end
						-- Customize picker keymaps (optional)
						picker_keymaps = {
							rename = { n = "r", i = "<M-r>" },
							delete = { n = "d", i = "<M-d>" },
							duplicate = { n = "<C-y>", i = "<C-y>" },
						},
						---Automatically generate titles for new chats
						auto_generate_title = true,
						title_generation_opts = {
							---Adapter for generating titles (defaults to current chat adapter)
							adapter = nil, -- "copilot"
							---Model for generating titles (defaults to current chat model)
							model = nil, -- "gpt-4o"
							---Number of user prompts after which to refresh the title (0 to disable)
							refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
							---Maximum number of times to refresh the title (default: 3)
							max_refreshes = 3,
							format_title = function(original_title)
								-- this can be a custom function that applies some custom
								-- formatting to the title.
								return original_title
							end,
						},
						---On exiting and entering neovim, loads the last chat on opening chat
						continue_last_chat = false,
						---When chat is cleared with `gx` delete the chat from history
						delete_on_clearing_chat = false,
						---Directory path to save the chats
						dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
						---Enable detailed logging for history extension
						enable_logging = false,

						-- Summary system
						summary = {
							-- Keymap to generate summary for current chat (default: "gcs")
							create_summary_keymap = "gcs",
							-- Keymap to browse summaries (default: "gbs")
							browse_summaries_keymap = "gbs",

							generation_opts = {
								adapter = nil, -- defaults to current chat adapter
								model = nil, -- defaults to current chat model
								context_size = 90000, -- max tokens that the model supports
								include_references = true, -- include slash command content
								include_tool_outputs = true, -- include tool execution results
								system_prompt = nil, -- custom system prompt (string or function)
								format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
							},
						},

						-- Memory system (requires VectorCode CLI)
						memory = {
							-- Automatically index summaries when they are generated
							auto_create_memories_on_summary_generation = true,
							-- Path to the VectorCode executable
							vectorcode_exe = "vectorcode",
							-- Tool configuration
							tool_opts = {
								-- Default number of memories to retrieve
								default_num = 10,
							},
							-- Enable notifications for indexing progress
							notify = true,
							-- Index all existing memories on startup
							-- (requires VectorCode 0.6.12+ for efficient incremental indexing)
							index_on_startup = false,
						},
					},
				},
			},
			opts = {
				system_prompt = function(opts)
					local function read_file(file_path)
						local file, err = io.open(file_path, "r") -- Open file in read mode
						if not file then
							print("Error opening file: " .. err)
							return nil
						end
						local content = file:read("*all") -- Read entire file
						file:close() -- Close the file
						return content
					end

					local system_prompt = read_file(vim.fn.expand("~/.config/nvim/system_prompt.txt"))

					if not system_prompt then
						vim.notify("Failed loading system prompt", vim.log.levels.WARN)
						return
					end

					vim.notify("Code companion system prompt loaded")
					return system_prompt
				end,
			},
			prompt_library = {
				["machine learning"] = {
					strategy = "chat",
					description = "An ai assistant for machine learning related topics",
					prompts = {
						{
							role = "system",
							content = "You are an expert in machine learning, your job is to explain machine concepts in depth for the user in Markdown",
						},
					},
					opts = {
						is_default = true,
						short_name = "ml",
					},
				},
			},
		}

		vim.keymap.set("n", "<leader>ai", function()
			local c = require("codecompanion")
			c.setup(conf)
			c.toggle()
		end, { silent = true })

		vim.keymap.set("n", "<leader>an", function()
			local c = require("codecompanion")
			c.setup(conf)
			c.chat()
		end, { silent = true })

		vim.keymap.set("n", "<leader>fai", function()
			local float_conf =
				vim.tbl_extend("force", conf, { display = { chat = { window = { layout = "float", width = 0.6 } } } })
			local c = require("codecompanion")
			c.setup(float_conf)
			c.prompt("ml")
		end, { silent = true })
	end,
}
