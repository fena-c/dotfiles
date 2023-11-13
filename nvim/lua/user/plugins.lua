local fn = vim.fn

-- Sección para ultisnips

--vim.g.UltiSnipsExpandTrigger = '<tab>'
--vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
--vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>'
--vim.g.UltiSnipsEditSplit="vertical"
vim.g.vimtex_view_method="sioyek"
vim.g.vimtex_view_general_viewer="sioyek"


-- local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
-- parser_config.typst = {
--   install_info = {
--     url = '~/.config/nvim/lua/user/tree-sitter-typst',
--     files = { 'src/parser.c' },
--     branch = 'main',
--   },
--   filetype = 'typst', -- if filetype does not agrees with parser name
-- }


-- require("lualine").setup()
-- require("catppuccin").setup()
-- require("nvim-autopairs").setup()
-- require("nvim-tree").setup()
-- require("mason").setup()
-- require("mason-lspconfig").setup()
-- require("lspconfig").pylsp.setup {
--     settings = {
--         pylsp = {
--             plugins = {
--                 pycodestyle = {
--                     maxLineLength = 100,
--                 },
--             },
--         },
--     },
-- }
-- require("lspconfig").typst_lsp.setup{
-- }
--
-- require'lspconfig'.typst_lsp.setup{}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


vim.g.mapleader = ","
vim.g.maplocalleader = ","


-- Install your plugins here
require("lazy").setup({
  -- My plugins here
    "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim

    "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins

    { "catppuccin/nvim", name = "catppuccin" },

    {
      'kyazdani42/nvim-tree.lua',
      dependencies = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
      },
      config = function()
          require("nvim-tree").setup()
      end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        build = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    },

    'lervag/vimtex',

    {"akinsho/toggleterm.nvim",
        version="v2.*",
        config = function()
            require("toggleterm").setup()
        end,
        keys = {
            {"<C-t>", ":ToggleTerm direction=float<cr>", desc="ToggleTerm"},
        },
    },
    "windwp/nvim-autopairs",

    -- use 'lukname-reineke/indent-blankline.nvim'

--    use 'sirver/ultisnips'
--     use 'JuliaEditorSupport/julia-vim'
--     use 'vimwiki/vimwiki'
    "folke/zen-mode.nvim",

    {
        "L3MON4D3/LuaSnip",
        -- follow latest relenamee.
        version="v<CurrentMajor>.*",
        -- install jsregexp (optional!:).
        build = "make install_jsregexp",
        config = function()
            require("luasnip").config.set_config({
                enable_autosnippets = true,
            })

            require "user.snippetdef"
            
            require("luasnip.loaders.from_lua").lazy_load({paths = "~/.config/nvim/snippets/luasnip"})

            vim.cmd [[
            " press <Tab> to expand or jump in a snippet. These can also be mapped separately
            " via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
            imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
            " -1 for jumping backwards.
            inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

            snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
            snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

            " For changing choices in choiceNodes (not strictly necessary for a basic setup).
            imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
            smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
            ]]

        end
    },

    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup()
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            require'lspconfig'.typst_lsp.setup{
            }
        end,
    },

    -- {'kaarmu/typst.vim', ft = {'typst'}},

})



