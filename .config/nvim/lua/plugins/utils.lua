-- =========================
-- Utility plugins
-- =========================

-- This file provides a collection of plugins for utility functions and
-- enhancements.

return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		ft = {
			"html",
			"javascriptreact",
			"typescriptreact",
		},
		"windwp/nvim-ts-autotag",
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = false,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"echasnovski/mini.icons",
		},
		config = function()
			-- Use one statusline globally.
			vim.opt.laststatus = 3
			-- Hide mode information from cmdline.
			vim.opt.showmode = false
			-- Hide cmdline.
			vim.opt.cmdheight = 0

			-- Mock nvim-web-devicons to use mini.icons instead.
			require("mini.icons").mock_nvim_web_devicons()

			require("lualine").setup({
				options = {
					global_status = true,
					disabled_filetypes = {
						"snacks_*",
						winbar = {
							"dap-view",
							"dap-repl",
							"dap-view-term",
						},
					},
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			-- TODO: Workaround till https://github.com/folke/which-key.nvim/issues/967
			show_help = false,
			win = {
				border = "single",
			},
		},
	},
	{
		ft = {
			"lua",
			"css",
			"html",
			"javascript",
			"typescript",
			"javascriptreact",
			"typescriptreact",
		},
		"catgoose/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			filetypes = {
				"lua",
				"css",
				"html",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
			},
			user_default_options = {
				names = false,
				tailwind = "lsp",
				tailwind_opts = {
					update_names = true,
				},
			},
		},
	},
}
