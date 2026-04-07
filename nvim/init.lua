local vim = vim

-- Bootstrap lazy.nvim
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

-- Options (from options.lua)
vim.g.gui_font_size = 8.5
vim.opt.mouse = "a"
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.re = 2
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.api.nvim_set_option("clipboard", "unnamedplus")

-- Plugins (from plugins.lua)
local keyset = vim.keymap.set
require("lazy").setup({
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
    "preservim/nerdtree",
    config = function()
      keyset('n', '<C-t>', ':NERDTreeToggle<CR>', {})
      keyset('n', '<C-i>', ':NERDTreeFind<CR>', {})
    end
  },
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/nvim-cmp"
})

-- LSP and Plugin Configuration (from lsp.lua)
-- for mason
if pcall(require, 'mason') then require('mason').setup() end

-- Set up nvim-cmp
local has_cmp, cmp = pcall(require, 'cmp')
if has_cmp then
  cmp.setup({
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'supermaven' }
    })
  })
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

-- show diagnostics in telescope
vim.api.nvim_set_keymap('n', '<C-d>', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })

-- Set up lspconfig
local has_cmp_lsp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local capabilities = has_cmp_lsp and cmp_nvim_lsp.default_capabilities() or nil
local servers = { 'lua_ls', 'ts_ls', 'rust_analyzer', 'gopls', 'clangd', 'pyright' }

local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
if has_mason_lspconfig then
  mason_lspconfig.setup {
    ensure_installed = servers,
    handlers = {
      function(server_name)
        require("lspconfig")[server_name].setup {
          capabilities = capabilities,
        }
      end,
    },
  }
end
