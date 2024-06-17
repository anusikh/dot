local dap = require("dap")
local mason_pack_path = os.getenv('HOME') .. '/.local/share/nvim/mason/packages'

dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = mason_pack_path .. '/codelldb/codelldb',
    args = { "--port", "${port}" }
  }
}

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
