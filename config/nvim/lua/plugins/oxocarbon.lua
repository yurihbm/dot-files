vim.opt.background = "dark"
vim.cmd.colorscheme("oxocarbon")
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#161616", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#161616", fg = "#d0d0d0" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#161616", fg = "#d0d0d0" })
-- Fix visibility for NonText characters.
vim.api.nvim_set_hl(0, "NonText", { fg = "#525252" })
