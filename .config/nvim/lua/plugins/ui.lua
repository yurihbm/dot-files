-- =========================
-- UI Plugins
-- =========================

-- This file provides a collection of plugins for user interface enhancements.

---@module 'snacks'

return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			indent = {
				enabled = true,
				indent = { char = "▏" },
				scope = { char = "▏" },
				chunk = { char = "▏" },
			},
			input = { enabled = true },
			notifier = { enable = true },
			picker = {
				enabled = true,
				sources = {
					explorer = {
						auto_close = true,
						layout = {
							cycle = true,
							layout = {
								box = "vertical",
								border = vim.g.border_style,
								backdrop = 100,
								width = 0.50,
								height = 0.60,
								min_width = 0.40,
								title = "{title} {live} {flags}",
								{
									win = "input",
									height = 1,
									border = "bottom",
								},
								{ win = "list" },
							},
						},
					},
					command_history = {
						layout = {
							layout = {
								backdrop = false,
								width = 0.5,
								min_width = 80,
								height = 0.4,
								min_height = 3,
								box = "vertical",
								border = vim.g.border_style,
								title = "{title}",
								title_pos = "center",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					},
				},
				layouts = {
					default = {
						layout = {
							backdrop = 100,
							box = "horizontal",
							width = 0.75,
							height = 0.90,
							{
								box = "vertical",
								border = vim.g.border_style,
								title = "{title} {live} {flags}",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
							{
								win = "preview",
								title = "{preview}",
								border = vim.g.border_style,
								width = 0.50,
							},
						},
					},
				},
			},
			quickfile = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
		keys = {
			-- File navigation and search.
			{
				"<leader>fb",
				function()
					Snacks.picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>fh",
				function()
					Snacks.picker.command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>fn",
				function()
					Snacks.picker.notifications()
				end,
				desc = "Notification History",
			},
			{
				"<leader>fe",
				function()
					Snacks.explorer()
				end,
				desc = "File Explorer",
			},
			{
				"<leader>fc",
				function()
					Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find Files",
			},
			{
				"<leader>fr",
				function()
					Snacks.picker.resume()
				end,
				desc = "Resume",
			},
		},
		dependencies = {
			"echasnovski/mini.icons",
			opts = {},
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			cmdline = {
				enabled = true,
				view = "cmdline",
			},
			messages = {
				enabled = true,
				view = "mini",
			},
			views = {
				mini = {
					align = "message-left",
					position = {
						row = -1,
						col = 0,
					},
				},
			},
			presets = {
				bottom_search = true,
				lsp_doc_border = true,
			},
		},
	},
}
