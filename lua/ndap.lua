local vim = vim

-- Set up nvim-dap
local dap = require("dap")
local mason_pack_path = os.getenv('HOME') .. '/.local/share/nvim/mason/packages'
local keyset = vim.keymap.set

-- adapters
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = mason_pack_path .. '/codelldb/codelldb',
    args = { "--port", "${port}" }
  }
}

-- configurations (edit these as per requirements)
dap.configurations.rust = {
  {
    name = "launch",
    type = "codelldb",
    request = "launch",
    program = 'cargo',
    args = { 'run', '--', 'lsrem' },
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

-- nvim-dap keymaps
keyset({ 'n' }, 'cd', ':DapContinue<CR>')
keyset({ 'n' }, 't', ':DapToggleBreakpoint<CR>')
keyset({ 'n' }, 'td', ':DapTerminate<CR>')
keyset({ 'n', 'v' }, 'h', function() require('dap.ui.widgets').hover() end)
keyset({ 'n', 'v' }, 'hp', function() require('dap.ui.widgets').preview() end)
