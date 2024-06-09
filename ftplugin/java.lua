local vim = vim
local mason_pack_path = os.getenv('HOME') .. '/.local/share/nvim/mason/packages'

-- set up lspconfig for java
local config = {
  cmd = { mason_pack_path .. '/jdtls/jdtls' },
  root_dir = vim.fs.root(0, { 'gradlew', '.git', 'mvnw' }),
}
require('jdtls').start_or_attach(config)


