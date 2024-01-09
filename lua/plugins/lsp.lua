local M = {}

M.setup = function()
  require('fidget').setup()
  local lspconfig = require('lspconfig')

  -- Diagnostics
  local sign = function(opts)
    vim.fn.sign_define(opts.name, {
      texthl = opts.name,
      text = opts.text,
      numhl = ''
    })
  end

  sign({ name = 'DiagnosticSignError', text = '✘' })
  sign({ name = 'DiagnosticSignWarn', text = '▲' })
  sign({ name = 'DiagnosticSignHint', text = '⚑' })
  sign({ name = 'DiagnosticSignInfo', text = '' })

  vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    float = {
      border = 'rounded',
      source = 'always',
    },
  })
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'rounded' }
  )

  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'rounded' }
  )

  -- CMP
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<c-y>"] = cmp.mapping(
        cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
        { "i", "c" }
      ),
      ["<M-y>"] = cmp.mapping(
        cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        { "i", "c" }
      ),

      ["<c-space>"] = cmp.mapping {
        i = cmp.mapping.complete(),
        c = function(
          _ --[[fallback]]
        )
          if cmp.visible() then
            if not cmp.confirm { select = true } then
              return
            end
          else
            cmp.complete()
          end
        end,
      },
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp', group_index = 1 },
      { name = 'copilot',  group_index = 1 },
      { name = 'luasnip',  group_index = 2 },
    }, {
      { name = 'buffer' },
    }),
    enabled = function()
      -- disable completion in comments
      local context = require 'cmp.config.context'
      -- keep command mode completion enabled when cursor is in a comment
      if vim.api.nvim_get_mode().mode == 'c' then
        return true
      else
        return not context.in_treesitter_capture("comment")
            and not context.in_syntax_group("Comment")
      end
    end
  })

  require("mason").setup({
    ensure_installed = {
      "goimports",
      "gofumpt",
      "gomodifytags",
      "impl",
      "delve",
      "js-debug-adapter",
    },
    ui = {
      icons = {
        package_installed = "✓",
        package_uninstalled = "✗",
        package_pending = "⟳",
      },
    },
  })
  require("mason-lspconfig").setup({
    ensure_installed = {
      'tsserver',
      'gopls',
      'pyright',
      'lua_ls',
      'eslint',
      'terraformls',
      'jsonls',
      'tflint',
      'volar',
      'clangd',

    },
    automatic_installation = true,
    handlers = {
      function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {}
      end,
      ["eslint"] = function()
        local util = require 'lspconfig.util'
        lspconfig.eslint.setup({
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
        })
        -- Copied from nvim-lspconfig/lua/lspconfig/server_conigurations/eslint.js
      end,
      ["lua_ls"] = function()
        lspconfig.lua_ls.setup({
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
        })
      end,
      ['gopls'] = function()
        lspconfig.gopls.setup({
          on_attach = function(client, bufnr)
            if not client.server_capabilities.semanticTokensProvider then
              local semantic = client.config.capabilities.textDocument.semanticTokens
              client.server_capabilities.semanticTokensProvider = {
                full = true,
                legend = {
                  tokenTypes = semantic.tokenTypes,
                  tokenModifiers = semantic.tokenModifiers,
                },
                range = true,
              }
            end
          end,
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                generate = true,
                gc_details = false,
                run_govulncheck = true,
                test = true,
                tidy = true,
                updgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = false,
              completeUnimported = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
              staticcheck = true,
            }
          },
        })
      end,
      ['tsserver'] = function()
        lspconfig.tsserver.setup({
          settings = {
            typescript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
            },
            javascript = {
              format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
              },
            },
            completions = {
              completeFunctionCalls = true,
            },
          }
        })
      end,
      ['clangd'] = function()
        lspconfig.clangd.setup({
          cmd = {
            'clangd',
            '--offset-encoding=utf=16',
          },
        })
      end
    }
  })
  local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
  local servers = { 'lua_ls', 'tsserver', 'pyright', 'gopls', 'clangd' }
  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
      capabilities = capabilities,
    }
  end
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'j-hui/fidget.nvim',
  },
  config = M.setup,
}
