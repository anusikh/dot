### neovim configuration

#### setup:
- clone repo in ~/.config/nvim
- setup vim plug (package manager), source and :PlugInstall
- use :Mason and install `codelldb` for rust debugging and `java-debug-adapter` and 'java-test' for java debugging
- then go to java.lua, and change config_linux to config_mac or vice-versa depending on OS

#### notes:
- lsp (ts, js, rust) handled by `mason`, `mason-lspconfig`, `nvim-lspconfig` and `nvim-cmp`
- lsp (java) handled by `nvim-jdtls`
- ftplugin is a special folder that store fileType based config, lsp should have single file mode for this to work
- find and replace globally: <C-r> (telescope), then search, then <C-q> (quicklist), then `:cdo s/<bef>/<after>/gc`
- find and replace in current file: `:%s/<bef>/<after>`
