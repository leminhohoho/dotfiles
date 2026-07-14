return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	settings = {
		python = {
			analysis = {
				autoImportCompletions = true,
				typeCheckingMode = "basic",
				diagnosticMode = "openFilesOnly",
				useLibraryCodeForTypes = true,
				stubPath = "typings",
				autoSearchPaths = true,
				extraPaths = {},
				diagnosticSeverityOverrides = {
					reportUnusedImport = "warning",
					reportUnusedVariable = "warning",
					reportOptionalMemberAccess = "warning",
					reportGeneralTypeIssues = "warning",
					reportMissingImports = "error",
				},
			},
		},
	},
}
