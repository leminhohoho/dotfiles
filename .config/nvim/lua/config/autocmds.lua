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

-- Lsp features
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc, silent = true })
		end

		-- defaults:
		-- https://neovim.io/doc/user/news-0.11.html#_defaults

		map("J", vim.diagnostic.open_float, "Open Diagnostic Float")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("<leader>gs", vim.lsp.buf.signature_help, "Signature Documentation")
		map("<leader>gr", require("telescope.builtin").lsp_references, "Signature Documentation")
		map("<leader>gd", vim.lsp.buf.definition, "Goto Definition")
		map("<leader>pd", require("goto-preview").goto_preview_definition, "Goto Declaration")
		map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
		map("<leader>ss", vim.lsp.buf.document_symbol, "Symbols")
		map("<leader>cr", function(...)
			vim.lsp.buf.rename(...)
		end, "Rename all references")
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

-- Add molten.nvim kernel status only when in python/markdown/ipynb files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "python", "ipynb" },
	callback = function()
		require("lualine").setup({
			sections = {
				lualine_y = {
					{
						function()
							return ""
						end,
						cond = function()
							return require("molten.status").kernels() ~= ""
						end,
						color = function()
							return {
								fg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Debug" }).fg),
							}
						end,
						padding = { left = 1, right = 0 },
					},
					{
						function()
							return require("molten.status").kernels()
						end,
						cond = function()
							return require("molten.status").kernels() ~= ""
						end,
					},
				},
			},
		})
	end,
})
