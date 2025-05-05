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
				local dap, dapui = require("dap"), require("dapui")
				dapui.setup()
				dap.listeners.before.attach.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.launch.dapui_config = function()
					dapui.open()
				end
				dap.listeners.before.event_terminated.dapui_config = function()
					dapui.close()
				end
				dap.listeners.before.event_exited.dapui_config = function()
					dapui.close()
				end

				dap.adapters.firefox = {
					type = "executable",
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js",
					},
				}

				local default_firefox_config = {
					name = "Debug with Firefox",
					type = "firefox",
					request = "launch",
					reAttach = true,
					url = "http://localhost:3000",
					webRoot = "${workspaceFolder}",
					firefoxExecutable = "/usr/bin/firefox",
				}

				dap.configurations.typescript = { default_firefox_config }
				dap.configurations.javascript = { default_firefox_config }
				dap.configurations.typescriptreact = { default_firefox_config }
				dap.configurations.javascriptreact = { default_firefox_config }

				dap.adapters.delve = function(callback, config)
					if config.mode == "remote" and config.request == "attach" then
						callback({
							type = "server",
							host = config.host or "127.0.0.1",
							port = config.port or "38697",
						})
					else
						callback({
							type = "server",
							port = "${port}",
							executable = {
								command = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv",
								args = { "dap", "-l", "127.0.0.1:${port}", "--log", "--log-output=dap" },
								detached = vim.fn.has("win32") == 0,
							},
						})
					end
				end

				dap.configurations.go = {
					{
						type = "delve",
						name = "Debug",
						request = "launch",
						program = "${file}",
						outputMode = "remote",
					},
					{
						type = "delve",
						name = "Debug test",
						request = "launch",
						mode = "test",
						program = "${file}",
						outputMode = "remote",
					},
					{
						type = "delve",
						name = "Debug test (go.mod)",
						request = "launch",
						mode = "test",
						program = "./${relativeFileDirname}",
						outputMode = "remote",
					},
				}

				local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
				local python_bin = os.getenv("VIRTUAL_ENV") and (os.getenv("VIRTUAL_ENV") .. "/bin/python")
					or mason_path

				dap.adapters.python = function(cb, config)
					if config.request == "attach" then
						local port = (config.connect or config).port
						local host = (config.connect or config).host or "127.0.0.1"
						cb({
							type = "server",
							port = assert(port, "`connect.port` is required for a python `attach` configuration"),
							host = host,
							options = {
								source_filetype = "python",
							},
						})
					else
						cb({
							type = "executable",
							command = python_bin,
							args = { "-m", "debugpy.adapter" },
							options = {
								source_filetype = "python",
							},
						})
					end
				end

				-- type, request and name are mandatory fields.
				-- Others options are configuration specific.
				-- see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
				-- for supported options.
				dap.configurations.python = {
					{
						type = "python",
						request = "launch",
						name = "Launch Django Server",
						program = "${workspaceFolder}/manage.py",
						args = { "runserver", "127.0.0.1:8000" },
						pythonPath = python_bin,
					},
					{
						type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
						request = "launch",
						name = "Launch file",

						program = "${file}", -- This configuration will launch the current file if used.
						pythonPath = python_bin,
					},
				}
			end,
		},
		"nvim-neotest/nvim-nio",
	},
}
