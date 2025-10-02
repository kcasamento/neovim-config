local M = {}

M.setupNavBuddy = function()
  local status_ok, navbuddy = pcall(require, "nvim-navbuddy")
  if not status_ok then return end

  navbuddy.setup({
    lsp = {
      auto_attach = true,
    }
  })
end

M.setup = function()
  local status_ok, navbuddy = pcall(require, "nvim-navbuddy")
  if not status_ok then return end

  require('fidget').setup()
  local lspconfig = vim.lsp.config

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


  local util = require 'lspconfig.util'

  vim.lsp.enable("lua_ls")
  vim.lsp.enable("elixirls")
  vim.lsp.enable("yamlls")
  vim.lsp.enable("helm_ls")
  vim.lsp.enable("gopls")
  vim.lsp.enable("eslint")
  vim.lsp.enable("ts_ls")
  vim.lsp.enable("clangd")


  vim.lsp.config("helm_ls", {
    settings = {
      ['helm-ls'] = {
        yamlls = {
          path = "yaml-language-server",
        }
      }
    }
  })

  vim.lsp.config("lua_ls", {
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
  )
  vim.lsp.config("eslint", {
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
  vim.lsp.config("gopls", {
    on_attach = function(client, bufnr)
      navbuddy.attach(client, bufnr)
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

  vim.lsp.config("ts_ls", {
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

  vim.lsp.config("clangd", {
    cmd = {
      'clangd',
      '--offset-encoding=utf=16',
    },
  })
end

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'mason-org/mason.nvim',
    'mason-org/mason-lspconfig.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'j-hui/fidget.nvim',
    {
      "SmiteshP/nvim-navbuddy",
      dependencies = {
        "SmiteshP/nvim-navic",
        "MunifTanjim/nui.nvim"
      },
      opts = { lsp = { auto_attach = true } },
      config = M.setupNavBuddy
    }
  },
  config = M.setup,
}
