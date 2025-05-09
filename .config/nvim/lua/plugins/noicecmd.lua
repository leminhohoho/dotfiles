return {
	"folke/noice.nvim",
	event = "VeryLazy",
	config = function()
		local noice = require("noice")

		vim.keymap.set("n", "<leader><leader>", "<cmd>NoiceDismiss<CR>")

		noice.setup({
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
				{
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = {
						skip = true,
					},
				},
			},
		})

		vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", { link = "Title" })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopUpTitle", { link = "Title" })
		vim.api.nvim_set_hl(0, "NoiceCmdlinePopUpBorder", { link = "Title" })
	end,
}
