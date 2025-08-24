return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {},
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		build = "make tiktoken",
		opts = {
			model = "gemini-2.5-pro",
			headers = {
				user = "## 👤 You ",
				assistant = "## 🤖 Copilot ",
				tool = "## 🔧 Tool ",
			},
			window = {
				layout = "float",
				border = vim.o.winborder,
				relative = "editor",
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
		dependencies = { "nvim-lua/plenary.nvim" },
	},
}
