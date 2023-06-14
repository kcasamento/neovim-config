local M = {}

function M.setup()
  local status_ok, navigator = pcall(require, 'navigator')
  if not status_ok then return end

  local util = require 'lspconfig.util'

  navigator.setup({
    mason = true,
    default_mapping = false,
    keymaps = {
      { key = 'K',  func = vim.lsp.buf.hover,                        desc = 'function hover' },
      { key = 'gr', func = require('navigator.reference').async_ref, desc = 'async_ref' },
      {
        mode = 'i',
        key = '<M-k>',
        func = vim.lsp.signature_help,
        desc = 'signature_help',
      },
      {
        key = '<c-k>',
        func = vim.lsp.buf.signature_help,
        desc = 'signature_help',
      },
      {
        key = 'g0',
        func = require('navigator.symbols').document_symbols,
        desc = 'document_symbols',
      },
      {
        key = 'gW',
        func = require('navigator.workspace').workspace_symbol_live,
        desc = 'workspace_symbol_live',
      },
      { key = '<c-]>', func = require('navigator.definition').definition, desc = 'definition' },
      {
        key = 'gd',
        func = function()
          require('telescope.builtin').lsp_definitions({ initial_mode = 'normal' })
        end,
        desc = 'definition'
      },
      -- { key = 'gd',    func = require('navigator.definition').definition, desc = 'definition' },
      { key = 'gD',    func = vim.lsp.buf.declaration,                    desc = 'declaration' },

      {
        key = 'gt',
        func = vim.lsp.buf.type_definition,
        desc = 'type_definition',
      },
      {
        key = 'gp',
        func = require('navigator.definition').definition_preview,
        desc = 'definition_preview',
      },
      {
        key = 'gP',
        func = require('navigator.definition').type_definition_preview,
        desc = 'type_definition_preview',
      },
      { key = '<Leader>gt', func = require('navigator.treesitter').buf_ts,  desc = 'buf_ts' },
      { key = '<Leader>gT', func = require('navigator.treesitter').bufs_ts, desc = 'bufs_ts' },
      { key = '<Leader>ct', func = require('navigator.ctags').ctags,        desc = 'ctags' },
      {
        key = '<Space>ca',
        mode = 'n',
        func = require('navigator.codeAction').code_action,
        desc = 'code_action',
      },
      {
        key = '<Space>ca',
        mode = 'v',
        func = require('navigator.codeAction').range_code_action,
        desc = 'range_code_action',
      },
      -- { key = '<Leader>re', func = 'rename()' },
      { key = '<Space>rn',  func = require('navigator.rename').rename, desc = 'rename' },
      { key = '<Leader>gi', func = vim.lsp.buf.incoming_calls,         desc = 'incoming_calls' },
      { key = '<Leader>go', func = vim.lsp.buf.outgoing_calls,         desc = 'outgoing_calls' },
      {
        key = 'gi',
        func = function()
          require 'telescope.builtin'.lsp_implementations({ initial_mode = 'normal' })
        end,
        desc = 'implementation'
      },
      { key = '<Space>D', func = vim.lsp.buf.type_definition,                     desc = 'type_definition' },
      {
        key = 'sd',
        func = function()
          require('telescope.builtin').diagnostics({ initial_mode = 'normal' })
        end,
        desc = '[S]how [D]iagnostics'
      },
      {
        key = 'gL',
        func = require('navigator.diagnostics').show_diagnostics,
        desc = 'show_diagnostics',
      },
      {
        key = 'gG',
        func = require('navigator.diagnostics').show_buf_diagnostics,
        desc = 'show_buf_diagnostics',
      },
      {
        key = '<Leader>dt',
        func = require('navigator.diagnostics').toggle_diagnostics,
        desc = 'toggle_diagnostics',
      },
      {
        key = 'of',
        func = vim.diagnostic.open_float,
        desc = 'open error in floating window',
      },
      {
        key = ']d',
        func = vim.diagnostic.goto_next,
        desc = 'next diagnostics',
      },
      {
        key = '[d',
        func = vim.diagnostic.goto_prev,
        desc = 'prev diagnostics',
      },
      {
        key = ']O',
        func = vim.diagnostic.set_loclist,
        desc = 'diagnostics set loclist',
      },
      { key = ']r',       func = require('navigator.treesitter').goto_next_usage, desc = 'goto_next_usage' },
      {
        key = '[r',
        func = require('navigator.treesitter').goto_previous_usage,
        desc = 'goto_previous_usage',
      },
      {
        key = '<C-LeftMouse>',
        func = vim.lsp.buf.definition,
        desc = 'definition',
      },
      {
        key = 'g<LeftMouse>',
        func = vim.lsp.buf.implementation,
        desc = 'implementation',
      },
      {
        key = '<Leader>k',
        func = require('navigator.dochighlight').hi_symbol,
        desc = 'hi_symbol',
      },
      {
        key = '<Space>wa',
        func = require('navigator.workspace').add_workspace_folder,
        desc = 'add_workspace_folder',
      },
      {
        key = '<Space>wr',
        func = require('navigator.workspace').remove_workspace_folder,
        desc = 'remove_workspace_folder',
      },
      {
        key = '<Space>gm',
        func = require('navigator.formatting').range_format,
        mode = 'n',
        desc = 'range format operator e.g gmip',
      },
      {
        key = '<Space>wl',
        func = require('navigator.workspace').list_workspace_folders,
        desc = 'list_workspace_folders',
      },
      {
        key = '<Space>la',
        mode = 'n',
        func = require('navigator.codelens').run_action,
        desc = 'run code lens action',
      },
    },
    lsp = {
      enabled = true,

      lua_ls = {
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
      },
      eslint = {
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
      },

      servers = { 'eslint', 'tflint' }
    },
  })
end

return M
