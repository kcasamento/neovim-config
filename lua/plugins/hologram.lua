local M = {}

function M.setup()
  local status_ok, hologram = pcall(require, "hologram")
  if not status_ok then return end
  require('hologram').setup {
    auto_display = true -- WIP automatic markdown image display, may be prone to breaking
  }
end

return {
  'edluffy/hologram.nvim',
  config = M.setup,
}
