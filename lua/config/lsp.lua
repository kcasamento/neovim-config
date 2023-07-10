-- currently this file is not used/loaded
-- as the navigator plugin has all lsp config
-- if the navigator plugin is removed, make
-- sure to load this file again for lsp configs to
-- load properly.
--
local M = {}

function M.setup()
  require("neodev").setup({})

  local status_ok, lspconfig = pcall(require, "lspconfig")
  if not status_ok then return end

  local util = require 'lspconfig.util'
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })


  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc, noremap = true })
    end
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    nmap('<leader>ld', vim.diagnostic.open_float, "Diagnostic Open Float")
    nmap('<leader>ca', vim.lsp.buf.code_action, "Code Action")
    nmap('K', vim.lsp.buf.hover, "Hover")
    nmap('gd', function() require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' }) end,
      "Go to Definition")
    nmap('gi', function() require 'telescope.builtin'.lsp_implementations({ initial_mode = 'normal' }) end,
      "Go to Implementations")
    nmap('gr', function() require('telescope.builtin').lsp_references() end, "Go to References")

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }

  local capabilities = require 'cmp_nvim_lsp'.default_capabilities()

  lspconfig['pyright'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  }

  lspconfig['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
  }

  lspconfig['gopls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    settings = {
      gopls = {
        codelenses = {
          generate = true,
          gc_details = false,
          test = true,
          tidy = true,
        },
        analyses = {
          unusedparams = true,
          unusedvariable = true,
        },
        staticcheck = true,
      }
    }
  }

  lspconfig['lua_ls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    capabilities = capabilities,
    runtime = {
      -- tell the language server which version of lua you're using (most likely luajit in the case of neovim)
      version = 'luajit',
    },
    diagnostics = {
      -- get the language server to recognize the `vim` global
      globals = { 'vim' },
    },
    workspace = {
      -- make the server aware of neovim runtime files
      library = vim.api.nvim_get_runtime_file("", true),
    },
    -- do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  }

  lspconfig.eslint.setup {
    -- Copied from nvim-lspconfig/lua/lspconfig/server_conigurations/eslint.js
    root_dir = util.root_pattern(
      '.eslintrc',
      '.eslintrc.js',
      '.eslintrc.cjs',
      '.eslintrc.yaml',
      '.eslintrc.yml',
      '.eslintrc.json'
    -- Disabled to prevent "No ESLint configuration found" exceptions
    -- 'package.json',
    ),
  }

  require 'lspconfig'.volar.setup {}
  lspconfig.vuels.setup {
    on_attach = on_attach,
  }
  require 'lspconfig'.terraformls.setup {}
  require 'lspconfig'.tflint.setup {}
end

return M
