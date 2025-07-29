-- Trigger file updating in real time
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	pattern = "*",
	command = "checktime",
})

-- Retrieve the initial (root) directory for telescope
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
	callback = function()
		local argv = vim.fn.argv()

		if #argv > 0 then
			local path = argv[1]

			local is_dir = vim.fn.isdirectory(path) == 1

			if is_dir then
				vim.cmd("cd " .. path)
			end
		end
	end,
})

-- Enable format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		local filetype = vim.bo.filetype

		-- NOTE: using lsp built in formatter for certain language for faster speed
		if filetype == "go" or filetype == "zig" then
			vim.lsp.buf.format()
		else
			require("conform").format({ bufnr = args.buf })
		end
	end,
})

-- Turn of Neovim built in 's zig formatter
vim.api.nvim_create_autocmd({ "VimEnter", "BufEnter" }, {
	pattern = "*.zig",
	callback = function()
		vim.g.zig_fmt_autosave = 0
	end,
})

-- Disable stay-center when on markdown files
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
	pattern = "*.md",
	callback = function()
		require("stay-centered").toggle()
		vim.opt_local.scrolloff = 23
	end,
})

-- Specific configuration for csv files
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
	pattern = "*.csv",
	callback = function()
		vim.cmd("CsvViewEnable")
		vim.opt_local.wrap = false
	end,
})

-- Lsp features
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- defaults:
		-- https://neovim.io/doc/user/news-0.11.html#_defaults

		map("J", vim.diagnostic.open_float, "Open Diagnostic Float")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<leader>gs", vim.lsp.buf.signature_help, "Signature Documentation")
		map("<leader>gd", vim.lsp.buf.definition, "Goto Declaration")
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("<leader>cr", vim.lsp.buf.rename, "Rename all references")
		map("<leader>sgd", "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>", "Goto Definition in Vertical Split")
	end,
})
