return {
	"mhartington/formatter.nvim",
	config = function()
		-- Config formatters per filetype using built in configs from formatter plugin
		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				css = {
					require("formatter.filetypes.css").prettier,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				go = {
					require("formatter.filetypes.go").gofmt,
				},
				c = {
					require("formatter.filetypes.c").clangformat,
				},
				cpp = {
					require("formatter.filetypes.cpp").clangformat,
				},
				python = {
					require("formatter.filetypes.python").ruff,
				},
				sh = {
					require("formatter.filetypes.sh").shfmt,
				},
			},
		})

		-- Format code on write (:w)
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd
		augroup("__formatter__", { clear = true })
		autocmd("BufWritePost", {
			group = "__formatter__",
			command = ":FormatWrite",
		})
	end,
}
