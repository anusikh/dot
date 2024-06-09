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
Plug('williamboman/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/nvim-cmp')
-- lsp for java
Plug('mfussenegger/nvim-jdtls')
vim.call("plug#end")

local keyset = vim.keymap.set

-- for trouble
if pcall(require, 'trouble') then require('trouble').setup() end

-- for Comment
if pcall(require, 'Comment') then require('Comment').setup() end

-- for nerdtree
keyset('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true })
keyset('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })
keyset('n', '<C-n>', ':NERDTree<CR>', { noremap = true })
keyset('n', '<C-f>', ':NERDTreeFind<CR>', { noremap = true })

-- for telescope
if pcall(require, 'telescope.builtin')
then
  local builtin = require('telescope.builtin')
  keyset('n', '<C-p>', builtin.find_files, {})
  keyset('n', '<C-r>', builtin.live_grep, {})
  keyset('n', '<leader>fb', builtin.buffers, {})
  keyset('n', '<leader>fh', builtin.help_tags, {})
end

require("options")
require("lsp_config")
require("dap_config")
