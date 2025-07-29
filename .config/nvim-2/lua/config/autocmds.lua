-- Functions to retreive the initial directory path (for telescope,...)
local function change_dir_from_argv()
	local argv = vim.fn.argv()

	if #argv > 0 then
		local path = argv[1]

		local is_dir = vim.fn.isdirectory(path) == 1

		if is_dir then
			vim.cmd("cd " .. path)
		end
	end
end

vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
	callback = change_dir_from_argv,
})

vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
	pattern = "*.zig",
	callback = function()
		vim.g.zig_fmt_autosave = 0
	end,
})

-- Enable format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		local filetype = vim.bo.filetype

		if filetype == "go" or filetype == "zig" then
			vim.lsp.buf.format()
		else
			require("conform").format({ bufnr = args.buf })
		end
	end,
})
--
-- -- Optisns for csv files
-- vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
-- 	callback = function(args)
-- 		filetype = vim.bo[args.buf].filetype
-- 		if filetype == "csv" then
-- 			vim.cmd("CsvViewEnable")
-- 			vim.opt.wrap = false
-- 		else
-- 			vim.cmd("CsvViewDisable")
-- 			vim.cmd("set wrap")
-- 			vim.cmd("set linebreak")
-- 		end
-- 	end,
-- })

-- Disable wrap for .dbout
vim.api.nvim_create_autocmd({ "BufRead", "BufRead", "BufNewFile" }, {
	pattern = "*.sql",
	callback = function()
		vim.cmd("setlocal wrap")
	end,
})
