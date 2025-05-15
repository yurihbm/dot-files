-- =========================
-- Completion Plugins
-- =========================

-- This file provides a collection of plugins for code completion/generation.

return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			false,
		},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		init = function()
			-- Disable default cmdline completion.
			vim.keymap.set("c", "<Tab>", "<Tab>", { noremap = true })
			vim.opt.wildmenu = false
			vim.opt.wildoptions = {}
		end,
		opts = {
			completion = {
				list = { selection = { preselect = false } },
				menu = { auto_show = true, border = vim.o.winborder },
				documentation = {
					window = { border = vim.o.winborder },
					auto_show = true,
					auto_show_delay_ms = 250,
				},
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
			},
			signature = { enabled = false, window = { border = vim.o.winborder } },
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<C-c>"] = { "cancel" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
			},
			cmdline = {
				enabled = true,
				keymap = {
					preset = "inherit",
					["<Tab>"] = { "show_and_insert", "select_next" },
					["<S-Tab>"] = { "show_and_insert", "select_prev" },
					["<CR>"] = { "accept_and_enter", "fallback" },
				},
				completion = { ghost_text = { enabled = false } },
			},
			sources = {
				default = { "copilot", "lsp", "path", "buffer" },
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
				},
			},
		},
		dependencies = {
			{
				"fang2hou/blink-copilot",
				event = "InsertEnter",
				dependencies = {
					{
						"CopilotC-Nvim/CopilotChat.nvim",
						event = "InsertEnter",
						branch = "main",
						dependencies = {
							{
								"zbirenbaum/copilot.lua",
								cmd = "Copilot",
								event = "InsertEnter",
								opts = {},
							},
							"nvim-lua/plenary.nvim",
						},
						opts = {
							window = {
								layout = "float",
								border = vim.o.winborder,
								relative = "win",
								width = 0.60,
								height = 0.75,
								backdrop = 100,
								title = " Copilot Chat ",
							},
						},
						keys = {
							{
								"<leader>cc",
								":CopilotChatToggle<CR>",
								mode = "n",
								desc = "Toggle Copilot Chat",
								silent = true,
							},
							{
								"<leader>cc",
								":<C-U>CopilotChatToggle<CR>",
								mode = "v",
								desc = "Toggle Copilot Chat",
								silent = true,
							},
						},
					},
				},
			},
		},
	},
}
