return {
	"nvim-mini/mini.nvim",
	config = function()
		local icons = require("mini.icons")
		icons.setup({
			extension = {
				["surql"] = { icon = "  ", color = "#FF00FF", name = "surrealql" },
			},
		})
	end,
}
