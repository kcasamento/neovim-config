local M = {}

function M.setup()
  local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status_ok then return end

  mason_lspconfig.setup({
    ensure_installed = {
      'tsserver',
      'gopls',
      'pyright',
      'lua_ls',
      'eslint',
      'terraformls',
    },
  })
end

return {
  'williamboman/mason-lspconfig.nvim',
  dependencies = { 'mason.nvim', 'nvim-lspconfig' },
  config = M.setup,
}
