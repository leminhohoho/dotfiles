vim.pack.add({"https://github.com/rmagatti/auto-session"})

require("auto-session").setup({
	auto_restore_enabled = false,
})

vim.keymap.set("n", "<leader>wr", ":AutoSession restore<CR>", { silent = true })
vim.keymap.set("n", "<leader>ws", ":AutoSession save<CR>", { silent = true })
