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
				menu = { auto_show = true, border = "single" },
				documentation = {
					window = { border = "single" },
					auto_show = true,
					auto_show_delay_ms = 250,
				},
				accept = {
					auto_brackets = {
						enabled = false,
					},
				},
			},
			signature = { enabled = false, window = { border = "single" } },
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<C-c>"] = { "cancel" },
				["<Esc>"] = { "cancel", "fallback" },
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
					["<Esc>"] = { "fallback" },
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
								border = "single",
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
