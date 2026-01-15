local keymap = vim.keymap.set

require("mini.extra").setup()

keymap("n", "fh", function()
	MiniExtra.pickers.history()
end, { desc = "Open History Picker" })
keymap("n", "fd", function()
	MiniExtra.pickers.diagnostic()
end, { desc = "Open Diagnostic Picker" })
