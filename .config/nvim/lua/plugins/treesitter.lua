-- =========================
-- Treesitter Plugin
-- =========================

-- This file provides a plugin for syntax highlighting and code parsing.

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")
		---@diagnostic disable-next-line: missing-fields
		configs.setup({
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"go",
				"typescript",
				"tsx",
				"javascript",
				"html",
				"css",
				"styled",
				"regex",
				"bash",
				"yaml",
				"toml",
				"prisma",
				"markdown",
				"dockerfile",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
