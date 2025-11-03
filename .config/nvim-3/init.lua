vim.hl = vim.highlight

require("config.remap")
require("config.lazy")
require("config.colors")
require("config.options")
require("config.autocmds")
require("config.lsp")
require("myplugins.hard")

vim.cmd("colorscheme gruvbox-material")
