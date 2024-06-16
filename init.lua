local vim = vim
local Plug = vim.fn['plug#']

vim.call("plug#begin")
Plug('preservim/nerdtree', { ['on'] = 'NERDTreeToggle' })
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('numToStr/Comment.nvim')
Plug('folke/trouble.nvim')
-- plugins for debugger
Plug('mfussenegger/nvim-dap')
-- plugins for lsp and autocomplete
Plug('williamboman/mason.nvim')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/nvim-cmp')
-- lsp for java
Plug('mfussenegger/nvim-jdtls')
vim.call("plug#end")

require("options")
require("plugins")
require("lsp")
require("ndap")
