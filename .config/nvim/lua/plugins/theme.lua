-- =========================
-- Themes Plugins
-- =========================

-- This file provides a collection of themes.

return {
	{
		"Mofiqul/dracula.nvim",
		config = function()
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "dracula",
				callback = function()
					-- Customize highlight groups for completion menu.
					vim.api.nvim_set_hl(0, "Pmenu", { bg = "#282a36", fg = "#f8f8f2" })
					vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#44475a", fg = "#50fa7b" })
					vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#44475a" })
					vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#6272a4" })
					-- Fix visibility for NonText characters.
					vim.api.nvim_set_hl(0, "NonText", { fg = "#6272a4" })
				end,
			})

			--	vim.opt.background = "dark"
			--	vim.cmd.colorscheme("dracula")
		end,
		lazy = true,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		config = function()
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "oxocarbon",
				callback = function()
					-- Customize highlight groups for completion menu and floating windows.
					vim.api.nvim_set_hl(0, "Pmenu", { bg = "#161616", fg = "#d0d0d0" })
					vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#161616", fg = "#d0d0d0" })
					vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#161616", fg = "#d0d0d0" })

					-- Fix visibility for NonText characters.
					vim.api.nvim_set_hl(0, "NonText", { fg = "#525252" })
				end,
			})

			vim.opt.background = "dark"
			vim.cmd.colorscheme("oxocarbon")
		end,
	},
}
