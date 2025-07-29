return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		opts = { noremap = true, silent = true },
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- "saghen/blink.cmp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local mason_lspconfig = require("mason-lspconfig")

			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

			local on_attach = function(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<leader>gr", function()
					require("telescope.builtin").lsp_references()
				end, opts)
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>pd", ":Lspsaga peek_definition<CR>", opts)
				vim.keymap.set("n", "J", function()
					vim.diagnostic.open_float()
				end, opts)
			end

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			mason_lspconfig.setup({
				ensure_installed = {
					"cssls",
					"volar",
					"pyright",
					"jdtls",
					"gopls",
					"clangd",
					"jsonls",
					"templ",
					"zls",
					"ts_ls",
				},
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					lspconfig[server_name].setup({
						on_attach = on_attach,
						-- capabilities = capabilities,
					})
				end,
				["gopls"] = function()
					lspconfig["gopls"].setup({
						on_attach = on_attach,
					})
				end,
			})
		end,
	},
	{
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
	},
}
