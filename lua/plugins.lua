local keyset = vim.keymap.set

return {
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
