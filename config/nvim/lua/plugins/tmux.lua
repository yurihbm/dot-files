local keymap = vim.keymap.set

require("vim-tmux-navigator").setup()

keymap("n", "<C-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", { silent = true })
keymap("n", "<C-j>", "<cmd><C-U>TmuxNavigateDown<cr>", { silent = true })
keymap("n", "<C-k>", "<cmd><C-U>TmuxNavigateUp<cr>", { silent = true })
keymap("n", "<C-l>", "<cmd><C-U>TmuxNavigateRight<cr>", { silent = true })
keymap("n", "<C-\\>", "<cmd><C-U>TmuxNavigateLastActive<cr>", { silent = true })
