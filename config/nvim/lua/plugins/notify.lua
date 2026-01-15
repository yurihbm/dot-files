local notify = require("mini.notify")

notify.setup({
	content = { sort = nil },
	window = {
		config = {
			border = vim.g.border_style,
			anchor = "NE",
			row = 1,
			col = vim.o.columns - 1,
		},
		winblend = 10,
	},
})
MiniNotify.make_notify()
vim.keymap.set("n", "gN", function()
	notify.show_history()
end, { desc = "Show Notification History" })
