local vim = vim

-- Set up nvim-dap
local keyset = vim.keymap.set

-- nvim-dap keymaps
keyset({ 'n' }, 'cd', ':DapContinue<CR>')
keyset({ 'n' }, 't', ':DapToggleBreakpoint<CR>')
keyset({ 'n' }, 'td', ':DapTerminate<CR>')
keyset({ 'n', 'v' }, 'h', function() require('dap.ui.widgets').hover() end)
keyset({ 'n', 'v' }, 'hp', function() require('dap.ui.widgets').preview() end)
