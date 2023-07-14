local M = {}

function M.setup()
  local status_ok, dapui = pcall(require, "dapui")
  if not status_ok then return end

  dapui.setup()
end

return M
