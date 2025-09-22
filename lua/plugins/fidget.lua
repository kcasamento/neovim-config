local M = {}

function M.setup()
  local status_ok, fidget = pcall(require, "fidget")
  if not status_ok then return end

  fidget.setup()
end

return {

  "j-hui/fidget.nvim",
  config = M.setup,
}
