vim.g.mapleader = " "
vim.hl = vim.highlight

require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.commands")
require("config.colors")
require("config.autocmds")
require("config.lsp")
require("myplugins.setup")
