local M = {}

function M.setup()
  local status_ok, mason = pcall(require, "mason")
  if not status_ok then return end

  mason.setup({
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
end

return {
  'williamboman/mason.nvim',
  config = M.setup,
}
