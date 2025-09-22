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
      "rust_analyzer",
      "lua_ls",
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
  'mason-org/mason.nvim',
  version = "^2.0.0",
  config = M.setup,
}

