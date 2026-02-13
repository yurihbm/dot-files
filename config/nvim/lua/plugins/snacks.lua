local keymap = vim.keymap.set

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("snacks").setup({
	bigfile = { enabled = true },
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
})

keymap("n", "e", function()
	Snacks.picker.resume("explorer")
end, { desc = "Open File Explorer" })
keymap("n", "ff", function()
	Snacks.picker.files()
end, { desc = "Open File Picker" })
keymap("n", "fg", function()
	Snacks.picker.grep()
end, { desc = "Open Grep Picker" })
keymap("n", "fb", function()
	Snacks.picker.buffers()
end, { desc = "Open Buffer Picker" })
keymap("n", "fc", function()
	Snacks.picker.command_history()
end, { desc = "Open Command Picker" })
keymap("n", "fr", function()
	Snacks.picker.resume()
end, { desc = "Resume Last Picker" })
