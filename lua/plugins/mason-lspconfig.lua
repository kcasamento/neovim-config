local M = {}

function M.setup()
  local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not status_ok then return end

  -- mason_lspconfig.setup({
  --   ensure_installed = {
  --     'ts_ls',
  --     'gopls',
  --     'pyright',
  --     'lua_ls',
  --     'eslint',
  --     'terraformls',
  --     'jsonls',
  --     "lua_ls",
  --   },
  --   automatic_enable = true,
  --
  -- })
end

return {
  'mason-org/mason-lspconfig.nvim',
  version = "^1.0.0",
  dependencies = { 'mason.nvim', 'nvim-lspconfig' },
  after = { "mason.nvim", "nvim-lspconfig" },
  config = M.setup,
}
