local M

M.defaults = {
	excludes = { ".env", "*.db", ".sync" },
}

M.opts = {}

M.setup = function(opts)
	M.opts = vim.tbl_deep_extend("force", M.defaults, opts or {})
end

return M
