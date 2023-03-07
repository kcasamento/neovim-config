local M = {}

function M.setup()
  local status_ok, lspconfig = pcall(require, "lspconfig")
  if not status_ok then return end

  local util = require 'lspconfig.util'
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })


  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('v', '<leader>la', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
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

  -- require'lspconfig'.volar.setup{}
  lspconfig.vuels.setup {
    on_attach = on_attach,
  }
end

return M
