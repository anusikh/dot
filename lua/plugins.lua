local vim = vim
local keyset = vim.keymap.set

-- for trouble
if pcall(require, 'trouble') then require('trouble').setup() end

-- for Comment
if pcall(require, 'comment') then require('comment').setup() end

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
