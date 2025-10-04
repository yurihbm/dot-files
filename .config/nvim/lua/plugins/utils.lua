-- =========================
-- Utility plugins
-- =========================

-- This file provides a collection of plugins for utility functions and
-- enhancements.

return {
	{
		"karb94/neoscroll.nvim",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"windwp/nvim-ts-autotag",
		ft = {
			"html",
			"javascriptreact",
			"typescriptreact",
		},
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
				sections = {
					lualine_c = {
						"filename",
					},
				},
			})
		end,
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
				tailwind = "both",
				tailwind_opts = {
					update_names = true,
				},
			},
		},
		{
			"OXY2DEV/markview.nvim",
			ft = { "markdown" },
			priority = 49,
			opts = {
				preview = {
					filetypes = { "markdown" },
					ignore_buftypes = {},
				},
			},
			dependencies = {
				"nvim-treesitter/nvim-treesitter",
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
		},
	},
}
