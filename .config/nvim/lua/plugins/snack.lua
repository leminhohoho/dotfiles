return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		image = {
			max_width = 120,
			math = {
				enabled = true,
				latex = { font_size = "Large" },
				tpl = [[
        \documentclass[preview,border=0pt,varwidth,10pt]{standalone}
        \usepackage{${packages}}
        \begin{document}
        ${header}
        { \${font_size} \selectfont
          \color[HTML]{${color}}
        ${content}}
        \end{document}]],
			},
		},
	},
}
