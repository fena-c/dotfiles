
local keymap = vim.api.nvim_set_keymap
local term_opts = { silent = true }
local opts = { noremap = true, silent = true }
require("toggleterm").setup{}

keymap("n", "<C-t>", ":ToggleTerm direction=float<cr>", opts)

-- keymap("n", "<leader>ne", ":NvimTreeToggle<cr>", opts)

