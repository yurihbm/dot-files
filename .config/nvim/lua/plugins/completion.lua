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
		opts = {
			completion = {
				list = {
					selection = {
						preselect = false,
					},
				},
				menu = { border = "rounded" },
				documentation = {
					window = { border = "rounded" },
					auto_show = true,
					auto_show_delay_ms = 250,
				},
			},
			signature = { window = { border = "single" } },
			keymap = {
				preset = "none",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<CR>"] = { "accept", "fallback" },
				["<C-c>"] = { "hide" },
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
			},
			cmdline = {
				enabled = true,
				keymap = { preset = "inherit" },
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
				dependencies = {
					{
						"CopilotC-Nvim/CopilotChat.nvim",
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
								border = "rounded",
								relative = "win",
								width = 0.60,
								height = 0.75,
								backdrop = 100,
								title = " Copilot Chat ",
							},
						},
						keys = {
							{ "<leader>cc", ":CopilotChatToggle<CR>", desc = "Toggle Copilot Chat" },
						},
					},
				},
			},
		},
	},
}
