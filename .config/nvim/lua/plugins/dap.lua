-- =========================
-- DAP (Debug Adapter Protocol) Plugins
-- =========================

-- This file provides a collection of plugins for code debugging.

return {
	"rcarriga/nvim-dap-ui",
	keys = {
		{
			"<leader>du",
			function()
				require("dapui").toggle()
			end,
			silent = true,
		},
	},
	dependencies = {
		{
			"mfussenegger/nvim-dap",
			keys = {
				{
					"<F2>",
					":lua require'dap'.step_over()<CR>",
					desc = "Step Over",
					silent = true,
				},
				{
					"<F3>",
					":lua require'dap'.step_into()<CR>",
					desc = "Step Into",
					silent = true,
				},
				{
					"<F4>",
					":lua require'dap'.step_out()<CR>",
					desc = "Step Out",
					silent = true,
				},
				{
					"<F5>",
					":lua require'dap'.continue()<CR>",
					desc = "Start/Continue Debugging",
					silent = true,
				},
				{
					"<leader>b",
					":lua require'dap'.toggle_breakpoint()<CR>",
					desc = "Toggle Breakpoint",
					silent = true,
				},
				{
					"<leader>lp",
					":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
					desc = "Set Log Point",
					silent = true,
				},
			},
			config = function()
				require("config.dap")
			end,
		},
		"nvim-neotest/nvim-nio",
	},
}
