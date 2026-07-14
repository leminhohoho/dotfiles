vim.pack.add({ "https://github.com/folke/flash.nvim" })

vim.keymap.set({ "n", "x", "o", "v" }, "s", function()
	require("flash").jump()
end, { silent = true })
