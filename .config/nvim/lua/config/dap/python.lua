-- =========================
-- Python DAP Configuration
-- =========================

-- This file provides the DAP configuration for Python.

local mason_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
local python_bin = os.getenv("VIRTUAL_ENV") and (os.getenv("VIRTUAL_ENV") .. "/bin/python") or mason_path

local dap = require("dap")

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
		type = "python",
		request = "launch",
		name = "Launch current file",
		program = "${file}",
		pythonPath = python_bin,
	},
}
