local M = {}

function M.setup()
  local status_ok, wk = pcall(require, "which-key")
  if not status_ok then return end

  wk.setup({})
end

return M
