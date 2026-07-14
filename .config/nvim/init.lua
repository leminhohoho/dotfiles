-- Set current directory to the one that neovim navigated to.
-- e.g nvim ~/.config/nvim in root set the directory to ~/.config/nvim instead of root
local argv = vim.fn.argv()

if #argv > 0 then
	local path = argv[1]

	local is_dir = vim.fn.isdirectory(path) == 1

	if is_dir then
		vim.cmd("cd " .. path)
	end
end

----------------------
--- Neovim options ---
----------------------

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 0
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.copyindent = true
vim.o.autoread = true
vim.o.showmode = false
vim.o.smoothscroll = true
vim.o.updatetime = 300
vim.o.swapfile = false
vim.o.wrap = true
vim.cmd("let g:netrw_liststyle = 3")
vim.g.netrw_banner = 0
vim.g.netrw_sort_sequence = [[[\/]$,*]]
vim.g.db_ui_execute_on_save = 0
vim.cmd("set linebreak")

--------------------
--- Key bindings ---
--------------------

vim.g.mapleader = " "

-- disable arrow keys
vim.keymap.set("n", "<up>", ':echo "Deez nuts"<CR>', { silent = true })
vim.keymap.set("n", "<down>", ':echo "Deez nuts"<CR>', { silent = true })
vim.keymap.set("n", "<left>", ':echo "Deez nuts"<CR>', { silent = true })
vim.keymap.set("n", "<right>", ':echo "Deez nuts"<CR>', { silent = true })

-- split buffers
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { silent = true })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { silent = true })

-- Go to start & end of line
vim.keymap.set({ "n", "v" }, "fh", "^", { silent = true })
vim.keymap.set({ "n", "v" }, "fl", "$", { silent = true })

-- Copy to clipboard
vim.keymap.set("v", "<leader>y", '"+y', { silent = true })
vim.keymap.set("n", "<leader>yy", '"+yy', { silent = true })

-- Turn of search highlight
vim.keymap.set("n", "<leader>th", ":nohlsearch<CR>", { silent = true })

-----------
--- LSP ---
-----------

vim.lsp.enable({
	"gopls",
	"lua_ls",
	"basedpyright",
	"ts_ls",
	"marksman",
	"harper_ls",
})

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		border = "none",
		source = true,
	},
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

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
		map("<leader>ss", require("telescope.builtin").lsp_document_symbols, "Symbols")
		map("<leader>cr", function(...)
			vim.lsp.buf.rename(...)
		end, "Rename all references")
	end,
})
