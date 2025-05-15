-- =========================
-- YAML LSP Configuration
-- =========================

-- This file provides a configuration for the YAML Language Server.

return {
	settings = {
		yaml = {
			schemas = require("schemastore").yaml.schemas(),
			redhat = { telemetry = { enabled = false } },
		},
	},
}
