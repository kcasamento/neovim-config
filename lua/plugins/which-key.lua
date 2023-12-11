local M = {}

function M.setup()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then return end

  wk.setup({})
end

return {
  "folke/which-key.nvim",
  config = M.setup,
}
