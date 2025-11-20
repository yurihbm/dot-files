return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {},
	},
	{
		"folke/sidekick.nvim",
		opts = {
			nes = {
				enabled = false,
			},
			cli = {
				watch = true, -- notify Neovim of file changes done by AI CLI tools
				---@class sidekick.win.Opts
				win = {
					layout = "float",
					float = {
						width = 0.6,
						height = 0.8,
					},
				},
			},
		},
		keys = {
			{
				"<leader>sc",
				function()
					require("sidekick.cli").toggle({ name = "copilot" })
				end,
				desc = "[S]idekick Toggle [C]opilot CLI",
			},
			{
				"<leader>sg",
				function()
					require("sidekick.cli").toggle({ name = "gemini" })
				end,
				desc = "[S]idekick Toggle [G]emini CLI",
			},
			{
				"<leader>ss",
				function()
					require("sidekick.cli").select({ filter = { installed = true } })
				end,
				desc = "[S]idekick [S]elect CLI",
			},
			{
				"<leader>sv",
				function()
					require("sidekick.cli").send({ msg = "{selection}" })
				end,
				mode = { "x" },
				desc = "[S]idekick Send [V]isual Selection",
			},
			{
				"<leader>sp",
				function()
					require("sidekick.cli").prompt()
				end,
				mode = { "n", "x" },
				desc = "[S]idekick Select [P]rompt",
			},
		},
	},
}
