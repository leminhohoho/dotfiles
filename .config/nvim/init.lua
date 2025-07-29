vim.hl = vim.highlight

require("config.remap")
require("config.lazy")
require("config.options")
require("config.autocmds")
require("config.colors")
require("config.lsp")

vim.cmd("colorscheme gruvbox-material")

