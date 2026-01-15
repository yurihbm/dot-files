local keymap = vim.keymap.set

require("mini.pick").setup({
	window = {
		prompt_caret = "█ ",
		prompt_prefix = "  ",
		config = {
			border = vim.g.border_style,
			-- Centered floating window
			anchor = "NW",
			height = math.floor(vim.o.lines * 0.6),
			width = math.floor(vim.o.columns * 0.4),
			row = math.floor(vim.o.lines * 0.2),
			col = math.floor(vim.o.columns * 0.3),
		},
	},
})
keymap("n", "ff", function()
	MiniPick.builtin.files()
end, { desc = "Open File Picker" })
keymap("n", "fg", function()
	MiniPick.builtin.grep_live()
end, { desc = "Open Grep Picker" })
keymap("n", "fb", function()
	MiniPick.builtin.buffers()
end, { desc = "Open Buffer Picker" })
keymap("n", "fr", function()
	MiniPick.builtin.resume()
end, { desc = "Resume Last Picker" })
