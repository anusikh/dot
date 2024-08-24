### neovim configuration

#### nvim setup:
- clone repo in ~/.config/nvim
- use :Mason and install the following:
    - `rust-analyzer`
    - `tsserver`
    - `lua_ls`
    - `jdtls`, 
    - `codelldb` 
    - `java-debug-adapter`
    - `java-test`
- then go to java.lua, and change config_linux to config_mac or vice-versa depending on OS

#### notes:
- lsp (ts, js, rust) handled by `mason`, `nvim-lspconfig` and `nvim-cmp`
- lsp (java) handled by `nvim-jdtls`
- ftplugin is a special folder that store fileType based config, lsp should have single file mode for this to work
- find and replace in current file: `:%s/<bef>/<after>`

### vim configuration

#### vim setup
- clone repo and run `ln -s ~/.config/nvim/.vimrc ~/.vimrc`
- pre-req: vim-plug, ripgrep
- source and run :PlugInstall to install all plugins
- install lang servers -> :CocInstall coc-java coc-json coc-tsserver coc-rust-analyzer coc-java-debug
- install debuggers -> :VimspectorInstall CodeLLDB
- for quickfix: open rg search, press tab on the item you want to add to quickfix and then press enter
- for commenting: ctrl+v, select lines, shift+i+<comment symbol>
- for un-commenting: ctrl+v, select lines (use arrow keys to move cursor if reqd), d
- for filetree use :Vexplore
- for java lombok support and kotlin language server add this in coc config
```
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
#### debugger support
- a sample .vimspector.json file for rust debugging
```
{
  "$schema": "https://puremourning.github.io/vimspector/schema/vimspector.schema.json",
  "adapters": {
    "CodeLLDB-localbuild": {
      "extends": "CodeLLDB",
      "command": [
        "$HOME/Development/vimspector/CodeLLDB/build/adapter/codelldb",
        "--port",
        "${unusedLocalPort}"
      ]
    }
  },
  "configurations": {
    "jvem -- current": {
      "adapter": "CodeLLDB",
      "configuration": {
        "request": "launch",
        "program": "cargo",
	    "args": ["run", "--", "current"],
        "expressions": "native"
      }
    }
  }
}
```

- a sample .vimspector.json file for java debugging
```
{
  "adapters": {
    "java-debug-server": {
      "name": "vscode-java",
      "port": "${AdapterPort}"
    }
  },
  "configurations": {
    "Java Attach": {
      "default": true,
      "adapter": "java-debug-server",
      "configuration": {
        "request": "attach",
        "host": "127.0.0.1",
        "port": "5005"
      },
      "breakpoints": {
        "exception": {
          "caught": "N",
          "uncaught": "N"
        }
      }
    }
  }
}
```
- first run the jar of a java application with command: java -jar -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 ./target/demo-0.0.1-SNAPSHOT.jar
then simply cd to attach debugger

