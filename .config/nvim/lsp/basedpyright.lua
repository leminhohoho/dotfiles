return {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	settings = {
		basedpyright = {
			analysis = {
				useLibraryCodeForTypes = true,
				typeCheckingMode = "off",
				diagnosticMode = "workspace",
				autoSearchPaths = true,
				inlayHints = {
					callArgumentNames = true,
				},
				extraPaths = {
					"...",
					"...",
				},
			},
			python = {
				venvPath = "/path/to/venv",
				venv = "venv",
			},
		},
	},
}
