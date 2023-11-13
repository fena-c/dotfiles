require "user.options"
require "user.keymaps"
require "user.plugins"
-- require "user.treesitter"
-- require "user.latex"
-- require "user.snippet"
-- require "user.term"

-- require("catppuccin").setup()
vim.g.catppuccin_flavour = "latte"
vim.cmd.colorscheme "catppuccin-mocha"

-- vim.cmd [[snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>]]

vim.filetype.add({extension = { typ = 'typst' }})

-- vim.keymap.set('i', '<Tab>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab'", { expr = true })
