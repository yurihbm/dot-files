-- =========================
-- DAP Configuration
-- =========================

-- This file provides the configuration for the Debug Adapter Protocol (DAP)
-- Plugin for Neovim (nvim-dap).

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

require("config.dap.python")
require("config.dap.go")
require("config.dap.js_ts")
