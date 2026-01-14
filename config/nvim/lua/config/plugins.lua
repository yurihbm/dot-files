local gh = function(x)
	return "https://github.com/" .. x
end
local autocmd = vim.api.nvim_create_autocmd
local keymap = vim.keymap.set

vim.pack.add({
	gh("folke/lazydev.nvim"),
	gh("nyoom-engineering/oxocarbon.nvim"),
	gh("neovim/nvim-lspconfig"),
	gh("nvim-treesitter/nvim-treesitter"),
	gh("b0o/schemastore.nvim"),
	gh("stevearc/conform.nvim"),
	gh("karb94/neoscroll.nvim"),
	gh("folke/which-key.nvim"),
	gh("windwp/nvim-autopairs"),
	gh("nvim-mini/mini.cursorword"),
	gh("nvim-mini/mini.icons"),
	gh("nvim-mini/mini-git"),
	gh("nvim-mini/mini.statusline"),
	gh("nvim-mini/mini.completion"),
	gh("nvim-mini/mini.cmdline"),
	gh("nvim-mini/mini.files"),
	gh("nvim-mini/mini.pick"),
	gh("windwp/nvim-ts-autotag"),
	gh("zbirenbaum/copilot.lua"),
})

require("lazydev").setup()

vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#161616", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#161616", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#161616", fg = "#d0d0d0" })
-- Fix visibility for NonText characters.
vim.api.nvim_set_hl(0, "NonText", { fg = "#525252" })

vim.lsp.config("jsonls", {
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})
vim.lsp.config("tailwindcss", {
	settings = {
		tailwindCSS = {
			classFunctions = { "tw", "twMerge", "tv", "clsx" },
		},
	},
})
vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemas = require("schemastore").yaml.schemas(),
			redhat = { telemetry = { enabled = false } },
		},
	},
})
vim.lsp.enable({
	"dockerls",
	"golangci_lint_ls",
	"gopls",
	"jsonls",
	"lua_ls",
	"prismals",
	"pyright",
	"tailwindcss",
	"ts_ls",
	"yamlls",
})

require("nvim-treesitter").install({
	"c",
	"lua",
	"vim",
	"vimdoc",
	"go",
	"typescript",
	"tsx",
	"javascript",
	"html",
	"css",
	"styled",
	"regex",
	"bash",
	"yaml",
	"toml",
	"prisma",
	"markdown",
	"markdown_inline",
	"dockerfile",
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c",
		"lua",
		"go",
		"typescript",
		"typescriptreact",
		"javascript",
		"javascriptreact",
		"html",
		"css",
		"bash",
		"yaml",
		"toml",
		"prisma",
		"markdown",
		"dockerfile",
	},
	callback = function()
		vim.treesitter.start()
	end,
})

autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})
require("conform").setup({
	formatters_by_ft = {
		css = { "prettierd" },
		go = { "gofmt" },
		javascript = { "prettierd" },
		javascriptreact = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		lua = { "stylua" },
		markdown = { "prettierd" },
		python = { "ruff" },
		sh = { "shfmt" },
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		yaml = { "prettierd" },
	},
})

require("neoscroll").setup()

require("which-key").setup({
	preset = "helix",
})

require("nvim-autopairs").setup()

require("mini.cursorword").setup()
require("mini.git").setup()
require("mini.icons").setup()
require("mini.statusline").setup()
vim.opt.laststatus = 3
require("mini.completion").setup()
vim.o.pumborder = "single"
require("mini.cmdline").setup()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("mini.files").setup({
	windows = {
		preview = true,
		width_focus = 40,
		width_nofocus = 40,
		width_preview = 40,
	},
})
keymap("n", "e", function()
	if not MiniFiles.close() then
		local buf_name = vim.api.nvim_buf_get_name(0)
		local path = nil

		-- Check if the buffer has a name and if the file actually exists on disk
		if buf_name ~= "" and vim.fn.filereadable(buf_name) == 1 then
			path = buf_name
		end

		-- Open MiniFiles. If 'path' is nil, it defaults to the Current Working Directory
		MiniFiles.open(path)

		-- Always reveal the cwd to ensure orientation
		MiniFiles.reveal_cwd()
	end
end)
local map_split = function(buf_id, lhs, direction)
	local rhs = function()
		-- Cria nova janela e define como alvo
		local cur_target = MiniFiles.get_explorer_state().target_window
		local new_target = vim.api.nvim_win_call(cur_target, function()
			vim.cmd(direction .. " split")
			return vim.api.nvim_get_current_win()
		end)

		MiniFiles.set_target_window(new_target)
		-- Ação extra: abre o arquivo e fecha o explorer para focar no código
		MiniFiles.go_in({ close_on_file = true })
	end

	local desc = "Split " .. direction
	keymap("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id
		-- Tweak keys to your liking
		map_split(buf_id, "<C-s>", "belowright horizontal")
		map_split(buf_id, "<C-v>", "belowright vertical")

		keymap("n", "gy", function()
			local path = (MiniFiles.get_fs_entry() or {}).path
			if path then
				vim.fn.setreg("+", path)
				vim.notify("Path yanked: " .. path)
			end
		end, { buffer = buf_id, desc = "Yank path" })
	end,
})
require("mini.pick").setup({
	window = {
		prompt_caret = "█ ",
		prompt_prefix = "  ",
		config = {
			border = vim.g.border_style,
			-- Centered floating window
			anchor = "NW",
			height = math.floor(vim.o.lines * 0.6),
			width = math.floor(vim.o.columns * 0.6),
			row = math.floor(vim.o.lines * 0.2),
			col = math.floor(vim.o.columns * 0.2),
		},
	},
})
keymap("n", "ff", function()
	MiniPick.builtin.files()
end)
keymap("n", "fg", function()
	MiniPick.builtin.grep_live()
end)
keymap("n", "fb", function()
	MiniPick.builtin.buffers()
end)
keymap("n", "fr", function()
	MiniPick.builtin.resume()
end)

require("nvim-ts-autotag").setup()

require("copilot").setup({
	suggestion = {
		hide_during_completion = false,
	},
	filetypes = {
		markdown = true,
	},
})
