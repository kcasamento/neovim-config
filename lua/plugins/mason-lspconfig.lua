local M = {}

function M.setup()
  local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status_ok then return end

  mason_lspconfig.setup({
    ensure_installed = {
      'ts_ls',
      'gopls',
      'pyright',
      'lua_ls',
      'eslint',
      'terraformls',
      'jsonls',
    },
  })
end

return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = { 'mason.nvim', 'nvim-lspconfig' },
  config = M.setup,
}
