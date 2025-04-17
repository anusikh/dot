### neovim configuration

#### install the following:
- nvim
- vim
- lazygit
- tmux
- vscode

#### nvim setup:
- clone repo in ~/.config/nvim
- install `java-debug-adapter`, `java-test` from mason for debugging capabilities
- go to java.lua, and change config_linux to config_mac or vice-versa depending on OS

#### notes:
- ftplugin is a special folder that store fileType based config, lsp should have single file mode for this to work
- find and replace in current file: `:%s/<bef>/<after>`

### vim configuration

#### vim setup
- clone repo and run `ln -s ~/.config/nvim/.vimrc ~/.vimrc`
- pre-req: vim-plug, ripgrep
- source and run :PlugInstall to install all plugins
- for java lombok support and kotlin language server add this in coc config

```json
{
  "java.jdt.ls.vmargs": "-javaagent:/home/anusikh/Downloads/lombok-1.18.34.jar",
  "java.jdt.ls.lombokSupport.enabled": true,
  "java.trace.server": "verbose",
  "java.jdt.ls.java.home": "/home/anusikh/.jvem/java",
  "languageserver": {
    "kotlin": {
      "command": "~/.local/share/nvim/mason/packages/kotlin-language-server/server/bin/kotlin-language-server",
      "filetypes": [
        "kotlin"
      ]
    }
  }
}
```

- first run the jar of a java application with command: java -jar -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 ./target/demo-0.0.1-SNAPSHOT.jar
then simply cd to attach debugger

