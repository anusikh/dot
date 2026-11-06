vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ── lazy.nvim bootstrap ─────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ── options ─────────────────────────────────────────────────────────────────
local o = vim.opt
o.mouse = "a"
o.autoindent = true
o.expandtab = true
o.tabstop = 2
o.shiftwidth = 2
o.backup = false
o.writebackup = false
o.updatetime = 300
o.signcolumn = "yes"
o.clipboard = "unnamedplus"
o.completeopt = { "menuone", "noselect", "popup" } 
o.pumheight = 12
o.splitright = true
o.splitbelow = true

vim.diagnostic.config({ virtual_text = true, severity_sort = true })

local caps = vim.lsp.protocol.make_client_capabilities()
caps.textDocument.completion.completionItem.snippetSupport = true
caps.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
caps.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentation", "detail", "additionalTextEdits" }, -- auto-imports on accept
}
vim.lsp.config("*", { capabilities = caps })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      diagnostics = { globals = { "vim" } },
      telemetry = { enable = false },
    },
  },
})

-- Install these with your package manager (pacman/npm/cargo/brew), not mason:
--   lua-language-server, typescript-language-server, rust-analyzer,
--   gopls, clangd, pyright
vim.lsp.enable({ "lua_ls", "ts_ls", "rust_analyzer", "gopls", "clangd", "pyright" })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user_lsp", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
    vim.keymap.set("n", "<leader>f", function()
      vim.lsp.buf.format({ async = true, bufnr = ev.buf })
    end, { buffer = ev.buf, desc = "Format buffer" })
  end,
})

vim.keymap.set("i", "<C-Space>", function() vim.lsp.completion.get() end, { desc = "LSP completion" })

vim.keymap.set("n", "<leader>fb", function()
  vim.ui.select(vim.fn.getbufinfo({ buflisted = 1 }), {
    prompt = "Buffers",
    format_item = function(b)
      local name = b.name == "" and "[No Name]" or vim.fn.fnamemodify(b.name, ":~:.")
      return (b.changed == 1 and "+ " or "  ") .. name .. ":" .. b.lnum
    end,
  }, function(choice)
    if choice then vim.api.nvim_set_current_buf(choice.bufnr) end
  end)
end, { desc = "Switch buffer" })

vim.keymap.set("n", "<leader>fh", function()
  vim.ui.select(vim.fn.getcompletion("", "help"), { prompt = "Help" }, function(choice)
    if choice then vim.cmd("help " .. choice) end
  end)
end, { desc = "Help tags" })

vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })

local function git_diff_head()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    vim.notify("Buffer has no file name.", vim.log.levels.WARN)
    return
  end
  local rel = vim.fn.systemlist({ "git", "ls-files", "--full-name", "--", file })[1]
  if not rel or rel == "" then
    vim.notify("File is not tracked by git.", vim.log.levels.WARN)
    return
  end
  local ft = vim.bo.filetype
  local lines = vim.fn.systemlist({ "git", "show", "HEAD:" .. rel })
  if vim.v.shell_error ~= 0 then
    vim.notify("git show failed for HEAD:" .. rel, vim.log.levels.ERROR)
    return
  end

  vim.cmd("botright vertical new")
  vim.cmd("setlocal buftype=nofile bufhidden=wipe noswapfile")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.filetype = ft

  vim.cmd("diffthis")
  vim.cmd("wincmd p")
  vim.cmd("diffthis")
end

vim.keymap.set("n", "<C-a>", git_diff_head, { desc = "Diff buffer against HEAD" })

require("lazy").setup({
  { "neovim/nvim-lspconfig", lazy = false },

  {
    "dmtrKovalenko/fff",
    lazy = false, -- the plugin initialises itself
    build = function()
      require("fff.download").download_or_build_binary()
    end,
    opts = { debug = { enabled = true, show_scores = true } },
    keys = {
      { "ff", function() require("fff").find_files() end, desc = "Find files" },
      { "fg", function() require("fff").live_grep() end, desc = "Live grep" },
      {
        "fz",
        function() require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } }) end,
        desc = "Fuzzy grep",
      },
      {
        "fw",
        function() require("fff").live_grep_under_cursor() end,
        mode = { "n", "x" },
        desc = "Search word / selection",
      },
    },
  },
}, { install = { missing = true } })
