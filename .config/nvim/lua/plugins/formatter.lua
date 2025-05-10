-- =========================
-- Formatter Plugin
-- =========================

-- This file provides a plugin for code formatting.

return {
	"mhartington/formatter.nvim",
	ft = { "c", "cpp", "css", "go", "json", "jsonc", "lua", "python", "sh" },
	config = function()
		-- Prettier configuration handling Yarn's PnP installs.
		local function prettier()
			local config = require("formatter.defaults.prettier")()
			local yarn_sdks_path = vim.fn.getcwd() .. "/.yarn/sdks"
			if vim.fn.isdirectory(yarn_sdks_path) == 1 then
				config.exe = "yarn"
				table.insert(config.args, 1, "exec")
				table.insert(config.args, 2, "prettier")
				config.try_node_modules = false
			end

			return config
		end

		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				c = {
					require("formatter.filetypes.c").clangformat,
				},
				cpp = {
					require("formatter.filetypes.cpp").clangformat,
				},
				css = {
					prettier,
				},
				go = {
					require("formatter.filetypes.go").gofmt,
				},
				json = {
					prettier,
				},
				jsonc = {
					prettier,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				python = {
					require("formatter.filetypes.python").ruff,
				},
				sh = {
					require("formatter.filetypes.sh").shfmt,
				},
			},
		})

		local augroup = vim.api.nvim_create_augroup
		local group = augroup("formatter", { clear = true })
		local autocmd = vim.api.nvim_create_autocmd
		autocmd("BufWritePost", {
			group = group,
			command = ":FormatWrite",
		})
	end,
	dependencies = {
		"williamboman/mason.nvim",
	},
}
