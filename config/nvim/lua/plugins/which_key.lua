local wk = require("which-key")

wk.setup({
	preset = "helix",
	triggers = {
		-- Trigger for Snacks keymaps. See `config/nvim/lua/plugins/snacks.lua`
		{ "f", mode = "n" },
	},
})
