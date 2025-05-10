return {
	"mhartington/formatter.nvim",
	ft = { "css", "lua", "go", "c", "cpp", "python", "sh" },
	config = function()
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
	end,
	init = function()
		local group = vim.api.nvim_create_augroup("formatter", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePost", {
			group = group,
			command = ":FormatWrite",
		})
	end,
}
