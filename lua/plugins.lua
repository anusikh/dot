local keyset = vim.keymap.set

return {
  {
    "preservim/nerdtree",
    config = function()
      keyset('n', '<leader>n', ':NERDTreeFocus<CR>', { noremap = true })
      keyset('n', '<C-t>', ':NERDTreeToggle<CR>', { noremap = true })
      keyset('n', '<C-n>', ':NERDTree<CR>', { noremap = true })
      keyset('n', '<C-f>', ':NERDTreeFind<CR>', { noremap = true })
    end
  },
  "nvim-lua/plenary.nvim",
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local builtin = require('telescope.builtin')
      keyset('n', '<C-p>', builtin.find_files, {})
      keyset('n', '<C-r>', builtin.live_grep, {})
      keyset('n', '<leader>fb', builtin.buffers, {})
      keyset('n', '<leader>fh', builtin.help_tags, {})
    end
  },
  {
    'echasnovski/mini.comment',
    version = '*',
    config = function()
      require('mini.comment').setup()
    end
  },
  {
    "folke/trouble.nvim",
    config = function()
      require('trouble').setup()
    end
  },
  "mfussenegger/nvim-dap",
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/nvim-cmp",
  "mfussenegger/nvim-jdtls",
}
