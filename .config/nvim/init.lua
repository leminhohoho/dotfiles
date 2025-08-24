vim.hl = vim.highlight

require("config.colors")
require("config.remap")
require("config.options")
require("config.autocmds")
require("config.lsp")
require("config.lazy")
require("myplugins.hard")

vim.cmd("colorscheme gruvbox-material")
