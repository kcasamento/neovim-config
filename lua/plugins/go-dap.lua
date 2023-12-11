local M = {}

function M.setup()
  local status_ok, dap = pcall(require, "dap-go")
  if not status_ok then return end

  dap.setup()
end

return {
  'leoluz/nvim-dap-go',
  config = M.setup,
}
