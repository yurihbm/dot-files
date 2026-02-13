local keymap = vim.keymap.set

keymap("c", "<Tab>", "<Tab>", { noremap = true })
vim.opt.wildmenu = false
vim.opt.wildoptions = {}

require("blink.cmp").setup({
	completion = {
		list = { selection = { preselect = false } },
		menu = { auto_show = true, border = vim.o.winborder },
		documentation = {
			window = { border = vim.o.winborder },
			auto_show = true,
			auto_show_delay_ms = 250,
		},
		accept = {
			auto_brackets = {
				enabled = false,
			},
		},
		trigger = { prefetch_on_insert = false },
	},
	signature = { enabled = false, window = { border = vim.o.winborder } },
	keymap = {
		preset = "none",
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<CR>"] = { "accept", "fallback" },
		["<C-c>"] = { "cancel" },
		["<C-j>"] = { "select_next", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},
	cmdline = {
		enabled = true,
		keymap = {
			preset = "inherit",
			["<C-j>"] = { "show_and_insert", "select_next" },
			["<Tab>"] = { "show_and_insert", "select_next" },
			["<C-k>"] = { "show_and_insert", "select_prev" },
			["<S-Tab>"] = { "show_and_insert", "select_prev" },
			["<CR>"] = { "accept_and_enter", "fallback" },
		},
		completion = { ghost_text = { enabled = false } },
	},
	sources = {
		default = { "copilot", "lsp", "buffer" },
		providers = {
			copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 100,
				async = true,
			},
		},
	},
})
