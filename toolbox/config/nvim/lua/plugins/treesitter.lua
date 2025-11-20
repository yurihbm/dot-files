-- =========================
-- Treesitter Plugin
-- =========================

-- This file provides a plugin for syntax highlighting and code parsing.

return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
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
				"markdown_inline",
				"dockerfile",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
	dependencies = { "OXY2DEV/markview.nvim" },
}
