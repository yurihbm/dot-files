vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.cmdheight = 0

require("mini.statusline").setup()

vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE", fg = "#525252" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { link = "Structure" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { link = "String" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { link = "Function" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { link = "Error" })
vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { link = "Operator" })
vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { bg = "NONE", fg = "#787878" })
vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = "NONE", fg = "#d0d0d0", bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { bg = "NONE", fg = "#d0d0d0" })
