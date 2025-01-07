-- Toggle Copilot Chat with ' cp'
vim.api.nvim_set_keymap("n", "<leader>cp", ":CopilotChatToggle<CR>", { noremap = true, silent = true })

return {
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
			},
		},
	},
	{
		"zbirenbaum/copilot-cmp",
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
	},
}
