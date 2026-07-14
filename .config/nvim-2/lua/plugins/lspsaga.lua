return {
	"nvimdev/lspsaga.nvim",
	config = function()
		local lspsaga = require("lspsaga")
		--lspsaga.init_lsp_saga { code_action_prompt = { enable = false, } }
		lspsaga.setup({
			ui = {
				code_action = "",
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
