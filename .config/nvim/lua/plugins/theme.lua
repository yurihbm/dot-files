return {
	"Mofiqul/dracula.nvim",
	config = function()
		vim.opt.background = "dark"
		vim.cmd("colorscheme dracula")

		-- Customize highlight groups for completion menu.
		vim.api.nvim_set_hl(0, "Pmenu", { bg = "#282a36", fg = "#f8f8f2" })
		vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#44475a", fg = "#50fa7b" })
		vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#44475a" })
		vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#6272a4" })
		-- Fix visibility for NonText characters.
		vim.api.nvim_set_hl(0, "NonText", { fg = "#6272a4" })
	end,
}
